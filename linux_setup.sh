#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VIMRC_SRC="$DOTFILES_DIR/.vimrc"

echo "[1/4] Install base packages + Clang toolchain"
if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y vim git curl nodejs npm \
    clang clang-tools clang-format clang-tidy clangd lldb lld
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y vim-enhanced git curl nodejs npm \
    clang clang-tools-extra lldb lld
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm vim git curl nodejs npm \
    clang lldb lld
else
  echo "Unknown pkg manager. Install: vim git curl nodejs npm clang lldb lld" >&2
fi

echo "[2/4] Place .vimrc"
[ -f "$VIMRC_SRC" ] && cp -f "$VIMRC_SRC" "$HOME/.vimrc" || echo "WARN: $VIMRC_SRC not found."

echo "[3/4] Ensure Prettier"
command -v prettier >/dev/null 2>&1 || npm i -g prettier

echo "[4/4] Install Powerline Fonts"
TMPF="$(mktemp -d)"
git clone --depth=1 https://github.com/powerline/fonts.git "$TMPF/fonts"
bash "$TMPF/fonts/install.sh"
rm -rf "$TMPF"

echo "Done. Start Vim and run :call dein#install()"
