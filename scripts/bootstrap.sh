#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it first: https://brew.sh"
  exit 1
fi

echo "Installing packages from Brewfile..."
BREWFILE_PATH="$DOTFILES_DIR/Brewfile"

if brew list --cask wezterm@nightly >/dev/null 2>&1; then
  echo "Detected wezterm@nightly; skipping stable wezterm cask from Brewfile."
  TMP_BREWFILE="$(mktemp)"
  trap 'rm -f "$TMP_BREWFILE"' EXIT
  grep -v '^cask "wezterm"$' "$DOTFILES_DIR/Brewfile" > "$TMP_BREWFILE"
  BREWFILE_PATH="$TMP_BREWFILE"
fi

brew bundle --file "$BREWFILE_PATH"

if brew list --cask font-jetbrains-mono >/dev/null 2>&1; then
  echo "JetBrains Mono is already installed."
else
  echo "Installing JetBrains Mono..."
  brew install --cask font-jetbrains-mono
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

mkdir -p "$ZSH_CUSTOM_DIR/plugins"

clone_plugin() {
  local repo="$1"
  local target="$2"
  if [ -d "$target/.git" ] || [ -d "$target" ]; then
    echo "Plugin already exists: $target"
  else
    git clone "$repo" "$target"
  fi
}

clone_plugin "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
clone_plugin "https://github.com/zsh-users/zsh-syntax-highlighting" "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
clone_plugin "https://github.com/zdharma-continuum/fast-syntax-highlighting" "$ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting"
clone_plugin "https://github.com/marlonrichert/zsh-autocomplete" "$ZSH_CUSTOM_DIR/plugins/zsh-autocomplete"
clone_plugin "https://github.com/MichaelAquilina/zsh-you-should-use" "$ZSH_CUSTOM_DIR/plugins/you-should-use"

echo "Linking dotfiles..."
"$DOTFILES_DIR/scripts/link.sh"

echo "Bootstrap complete."
echo "Next steps: run 'nvim' once to install plugins, then run 'exec zsh'."
