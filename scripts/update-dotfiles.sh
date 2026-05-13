#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

cd "$DOTFILES"

echo "Updating package lists..."
if [ -f scripts/update-pkglist.sh ]; then
    ./scripts/update-pkglist.sh
fi

echo
echo "Git status:"
git status --short

echo
read -rp "Commit message: " COMMIT_MSG

git add .

git commit -m "$COMMIT_MSG"

git push

echo
echo "Dotfiles updated successfully."
