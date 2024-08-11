#!/usr/bin/env bash

desired_fonts=(
    "Cousine"
)

nerd_fonts_dir="/tmp/nerd-fonts"

if [ "$(uname -m)" == "Darwin" ]; then
    brew tap homebrew/cask-fonts
    for font_name in "${desired_fonts[@]}"; do
        brew install --cask "font-${font_name}"
    done
else
    if [ ! -d $nerd_fonts_dir ]; then
        git clone --depth=1 https://github.com/ryanoasis/nerd-fonts $nerd_fonts_dir
    fi

    if [ $? -eq 0 ]; then
        cd /tmp/nerd-fonts || exit
    else
        echo "failed to clone the upstream nerd-fonts repo"
        exit 1
    fi

    delete_nerd_fonts_dir=true

    for font_name in "${desired_fonts[@]}"; do
        ./install.sh "$font_name"
        # If something goes wrong we want to keep nerd-fonts around so we can run again
        if [ $? -ne 0 ]; then
            delete_nerd_fonts_dir=false
        fi
    done

    cd "$OLDPWD" || exit

    if $delete_nerd_fonts_dir; then
        rm -rf /tmp/nerd-fonts
    fi
fi
