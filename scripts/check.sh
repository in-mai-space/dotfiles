#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

ok() {
  echo "[OK] $1"
}

fail() {
  echo "[FAIL] $1"
  FAILED=1
}

echo "Running dotfiles checks..."

if zsh -n "$DOTFILES_DIR/.zshrc"; then
  ok ".zshrc syntax"
else
  fail ".zshrc syntax"
fi

if command -v luac >/dev/null 2>&1; then
  for f in "$DOTFILES_DIR"/wezterm/.wezterm.lua "$DOTFILES_DIR"/wezterm/config/*.lua "$DOTFILES_DIR"/nvim/lua/config/keymaps.lua; do
    if luac -p "$f"; then
      ok "lua syntax: ${f#$DOTFILES_DIR/}"
    else
      fail "lua syntax: ${f#$DOTFILES_DIR/}"
    fi
  done
else
  echo "[SKIP] luac not found"
fi

if command -v nvim >/dev/null 2>&1; then
  if nvim --headless "+qa"; then
    ok "nvim headless startup"
  else
    fail "nvim headless startup"
  fi
else
  echo "[SKIP] nvim not found"
fi

if [ "$(readlink "$HOME/.config/nvim" 2>/dev/null || true)" = "$DOTFILES_DIR/nvim" ]; then
  ok "~/.config/nvim symlink"
else
  fail "~/.config/nvim symlink"
fi

if [ "$(readlink "$HOME/.wezterm.lua" 2>/dev/null || true)" = "$DOTFILES_DIR/wezterm/.wezterm.lua" ]; then
  ok "~/.wezterm.lua symlink"
else
  fail "~/.wezterm.lua symlink"
fi

if [ "$(readlink "$HOME/.zshrc" 2>/dev/null || true)" = "$DOTFILES_DIR/.zshrc" ]; then
  ok "~/.zshrc symlink"
else
  fail "~/.zshrc symlink"
fi

if [ "$FAILED" -ne 0 ]; then
  echo ""
  echo "One or more checks failed."
  exit 1
fi

echo ""
echo "All checks passed."
