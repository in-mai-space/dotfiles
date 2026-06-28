#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.config"

if [ -e "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d%H%M%S)"
fi

if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
fi

if [ -e "$HOME/.config/zed" ] && [ ! -L "$HOME/.config/zed" ]; then
  mv "$HOME/.config/zed" "$HOME/.config/zed.backup.$(date +%Y%m%d%H%M%S)"
fi

ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/zed" "$HOME/.config/zed"

echo "Linked nvim, wezterm, zsh, and zed configs from $DOTFILES_DIR"
