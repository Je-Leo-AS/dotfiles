#!/bin/bash

mkdir -p pkglist

echo "Updating package lists..."

pacman -Qqe > pkglist/pacman.txt
pacman -Qqm > pkglist/aur.txt
pacman -Qe  > pkglist/explicit.txt

echo "Done."
