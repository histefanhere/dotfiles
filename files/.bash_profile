. ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Source cargo env (if folder exists)
if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi
