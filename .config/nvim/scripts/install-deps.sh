#!/usr/bin/env bash

desired_packages=(
    "ripgrep"
    "fd-find"
    "npm"
)

if [ "$(uname -m)" == "Mac" ]; then
    brew install ${desired_packages[@]}
fi

if [ -f /etc/os-release ]; then
    . /etc/os-release
fi

case "${ID,,}" in
    "debian") sudo apt install ${desired_packages[@]} ;;
    "fedora") sudo dnf install ${desired_packages[@]} ;;
    *) echo "Sorry, '${ID} is not currently supported for setup" && exit 1 ;;
esac
