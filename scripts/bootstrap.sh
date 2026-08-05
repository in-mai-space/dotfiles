#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it first: https://brew.sh"
  exit 1
fi

SKIP_WEZTERM_CASK=false
if brew list --cask wezterm@nightly >/dev/null 2>&1; then
  echo "Detected wezterm@nightly; will skip stable wezterm cask."
  SKIP_WEZTERM_CASK=true
fi

echo "Installing formulae and mas apps..."
TMP_NO_CASKS="$(mktemp)"
trap 'rm -f "$TMP_NO_CASKS"' EXIT
grep -v '^cask ' "$DOTFILES_DIR/Brewfile" > "$TMP_NO_CASKS"
brew bundle --file "$TMP_NO_CASKS"

install_cask_if_missing() {
  local cask="$1"
  if brew list --cask "$cask" >/dev/null 2>&1; then
    echo "  $cask: already installed via Homebrew, skipping"
    return
  fi
  local app_name
  app_name=$(brew info --cask --json=v2 "$cask" 2>/dev/null | \
    python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for artifact in data['casks'][0].get('artifacts', []):
        if isinstance(artifact, dict) and 'app' in artifact:
            print(artifact['app'][0])
            break
except:
    pass
" 2>/dev/null || echo "")
  if [ -n "$app_name" ] && { [ -d "/Applications/$app_name" ] || [ -d "$HOME/Applications/$app_name" ]; }; then
    echo "  $cask: '$app_name' already installed, skipping"
    return
  fi
  echo "  Installing $cask..."
  brew install --cask "$cask"
}

echo "Installing casks (skipping already-installed apps)..."
while IFS= read -r cask; do
  if [ "$cask" = "wezterm" ] && [ "$SKIP_WEZTERM_CASK" = "true" ]; then
    echo "  wezterm: skipping (wezterm@nightly is installed)"
    continue
  fi
  install_cask_if_missing "$cask"
done < <(grep '^cask ' "$DOTFILES_DIR/Brewfile" | sed 's/^cask "\(.*\)"$/\1/')

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


echo "Applying macOS defaults..."
"$DOTFILES_DIR/scripts/macos.sh"

echo "Installing node and Claude Code..."
mise use --global node@lts
mise exec -- npm install -g @anthropic-ai/claude-code

echo "Installing nvim plugins..."
nvim --headless "+Lazy! sync" +qa

echo ""
echo "Bootstrap complete."
echo "Run 'exec zsh' to reload your shell."
