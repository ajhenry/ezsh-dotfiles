# This my personal zshrc configs. Feel free to use it and modify according to your needs
# Place all your .zshrc configurations (including this one) in a single or multiple files under ~/.config/ezsh/zshrc/ folder

# Additional OH-MY-ZSH plugins to enable
plugins+=(
    docker
    docker-compose
    pyenv
    pip
    zsh-you-should-use
    print-alias
    git
    python
    colorize
    fzf
)

# Alias python3 to python
alias python="python3"

# Print alias config
export PRINT_ALIAS_PREFIX=$'\e[2m(alias) ──> '
export PRINT_ALIAS_FORMAT=$'\e[2m'
export PRINT_NON_ALIAS_FORMAT=$'\e[2m'

export PRINT_ALIAS_IGNORE_REDEFINED_COMMANDS=true
export PRINT_ALIAS_IGNORE_ALIASES=(example_alias)

# add root tools to path
export PATH=/usr/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# Go path
if [ ! -d "$HOME/dev" ]; then
    mkdir -p $HOME/dev
fi
if [ ! -d "$HOME/dev/go" ]; then
    mkdir -p $HOME/dev/go
fi

# Set encoding
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
