#!/usr/bin/env bash

git clone https://github.com/ryanoasis/nerd-fonts /tmp/nerd-fonts && cd /tmp/nerd-fonts
./install.sh && cd $OLDPWD && rm -rf /tmp/nerd-fonts
