#!/usr/bin/env bash

sudo pacman -Syu --needed - < ~/dotfiles/pkglist/pacman.txt

if command -v yay >/dev/null; then
    yay -S --needed - < ~/dotfiles/pkglist/aur.txt
fi
