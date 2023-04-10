# RC injection specific settings
STARTING_MARKER="########## MICHOHL DOTFILES BEGINNING MARKER ##########"
ENDING_MARKER="########## MICHOHL DOTFILES ENDING MARKER ##########"


# Determine if our custom RC commands are present in the equivelant of ~/.bashrc
is_injected_rc(){
    if [ -n "$(get_injected_rc_content $1)" ]; then
        return 0
    else
        return 1
    fi
}

# Return our custom injected content in the existing shell config
get_injected_rc_content(){
    rc_path="$1"
    sed -n '/^'"$STARTING_MARKER"'/,/^'"$ENDING_MARKER"'/{p;/^'"$ENDING_MARKER"'/q}' "$rc_path" | grep -v "MICHOHL"
}

# Depending on what type of shell we're configuring find the appropriate template
get_upstream_rc_path(){
    upstream_rc_file=$(basename "$1")
    echo "$script_dir/files/$upstream_rc_file"
}

# Return only the part of the ~/.bashrc that contains our custom injection
get_injected_rc_diff(){
    rc_path="$1"
    upstream_rc_path=$(get_upstream_rc_path "$rc_path")
    echo "LEFT == $upstream_rc_path && RIGHT == $rc_path injected content"
    get_injected_rc_content "$rc_path" | diff -y "$upstream_rc_path" -
}

# Actually inject the content
inject_rc_content(){
    rc_path="$1"
    upstream_rc_path=$(get_upstream_rc_path "$rc_path")

    if ! [ -f "$rc_path" ]; then
        echo "$rc_path does not exist. Skipping..."
        return 1
    fi

    if get_injected_rc_content "$rc_path" | cmp --silent "$upstream_rc_path" -; then
        echo "$upstream_rc_path and $rc_path are equivalent. Skipping..."
        return 0
    fi

    if ! is_injected_rc "$rc_path"; then
        echo ""                                 >> "$rc_path"
        echo "$STARTING_MARKER"                 >> "$rc_path"
        cat  "$(get_upstream_rc_path $rc_path)" >> "$rc_path"
        echo "$ENDING_MARKER"                   >> "$rc_path"
    else

        get_injected_rc_diff "$rc_path"

        while [ "$rc_option" != "y" ] && [ "$rc_option" != "n" ]; do
            printf "Existing injected content in your $(basename $rc_path). Would you like to overwrite it [Y/n] (default 'n')? "
            read -r rc_option
            rc_option=$(echo "$rc_option" | tr '[:upper:]' '[:lower:]')
        done

        if [ "$rc_option" = "y" ]; then
            # Escape all newlines so we can use sed to replace the content between our markers
            # Also escape backslashes since sed will not respect them by default
            formatted_injected_content=$(cat "$upstream_rc_path" | sed 's/\\/\\\\/g' | sed ':a;N;$!ba;s/\n/\\n/g')

            # Use short variables so our sed expression fits on the screen :(
            x="$STARTING_MARKER"
            y="$ENDING_MARKER"

            # Replace our injected content in the target file with our new content
            sed -i -e \
                '/'"$x"'/,/'"$y"'/c\'"$x"'\n'"$formatted_injected_content"'\n'"$y"'' \
                "$rc_path"
        else
            return 0
        fi
    fi
}
