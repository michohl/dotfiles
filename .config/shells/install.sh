#!/usr/bin/env sh

# Since this script in _THEORY_ should handle all types of shells we might use then I
# want this script to be POSIX compliant shell to cover the most systems

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# Source helper scripts
. "$script_dir/helper_scripts/rc_injection.sh"

install_bash_aliases(){
    upstream_config="$script_dir/files/.bash_aliases"
    target_config="$HOME/.bash_aliases"


    if [ -f "$target_config" ]; then
        if cmp --silent "$upstream_config" "$target_config"; then
            echo "$upstream_config and $target_config are equivalent. Skipping..."
            return 0
        fi


        echo "LEFT == $upstream_config && RIGHT == $target_config"
        diff -y "$upstream_config" "$target_config"

        while [ "$bash_alias_option" != "a" ] && [ "$bash_alias_option" != "o" ]; do
            printf "Existing bash_aliases in your home directory. Would you like to [o]verwrite it or [a]ppend to it (default 'a')? "
            read -r bash_alias_option
            bash_alias_option=$(echo "$bash_alias_option" | tr '[:upper:]' '[:lower:]')
        done

        if [ "$bash_alias_option" = "a" ]; then
            cat "$upstream_config" >> "$target_config"
            return 0
        fi

        if [ "$bash_alias_option" = "o" ]; then
            cp "$upstream_config" "$target_config"
            return 0
        fi

        echo "Invalid option proivded. Shouldn't have been able to get here. Aborting..."
        return 1
    else
        cp "$upstream_config" "$target_config"
    fi
}

setup_shells(){

    if [ -f "$HOME/.bashrc" ]; then
        echo "Setting up Bash"
        inject_rc_content "$HOME/.bashrc"
        install_bash_aliases
    fi

    if [ -f "$HOME/.zshrc" ]; then
        echo "Setting up ZSH"
        inject_rc_content "$HOME/.zshrc"
    fi

}

setup_shells
