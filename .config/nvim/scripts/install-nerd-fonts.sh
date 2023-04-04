#!/usr/bin/env bash

desired_fonts=(
    "cousine-nerd-font"
)

if [ "$(uname -m)" == "Darwin" ]; then
    brew tap homebrew/cask-fonts
    for font_name in "${desired_fonts[@]}"; do
        brew install --cask "font-${font_name}"
    done
else
    git clone https://github.com/ryanoasis/nerd-fonts /tmp/nerd-fonts && cd /tmp/nerd-fonts || exit

    for font_name in "${desired_fonts[@]}"; do
        ./install.sh "$font_name"
    done

    cd "$OLDPWD" || exit
    rm -rf /tmp/nerd-fonts
fi
