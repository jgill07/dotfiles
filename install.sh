#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

# Create symlinks for zsh configuration file
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

echo "Linked ~/.zshrc -> $DOTFILES/.zshrc"