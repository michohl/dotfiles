#!/usr/bin/env bash

# This script is meant to compliment fzf-preview by taking in the path we want to preview and
# doing some analysis on the file to determine what matter of previewing it makes the most sense.
#
# Currently we're only doing analysis on whether the file is a file or a directory but we could get more
# granular if we wanted and do separate commands based on things like file extensions.
#
# This can be leveraged in a ~/.zshrc file like so (assumming this script is in your $PATH):
# zstyle ':fzf-tab:complete:*' fzf-preview 'fzf-pretty.sh $realpath'

_file_or_dir() {
    p=$1

    if [ -d "${p}" ]; then
        tree -C "$p"
    fi

    if [ -f "${p}" ]; then

        if which bat >> /dev/null; then
            bat --style="${BAT_STYLE:-numbers}" --color=always --pager=never -- "$p"
        else
            cat "$p"
        fi
    fi
}

_file_or_dir "$1"
