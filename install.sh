#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Install Homebrew if missing
command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies from Brewfile
brew bundle --file="$DOTFILES/Brewfile"

# Create symlinks for zsh configuration file
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

echo "Linked ~/.zshrc -> $DOTFILES/zsh/.zshrc"