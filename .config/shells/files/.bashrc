# Update PATH for Go
#export GOROOT=$HOME/go
#export GOPATH="$GOROOT"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Customize the bash prompt
if which starship >> /dev/null; then
    eval "$(starship init bash)"
else
    PS1="\u@\e[0;32m\h\033[0m:\W $ "
fi
