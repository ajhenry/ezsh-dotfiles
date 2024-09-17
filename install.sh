#!/bin/bash

if command -v zsh &>/dev/null && command -v git &>/dev/null && command -v wget &>/dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget autoconf || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

if mv -n ~/.zshrc "$HOME/.zshrc-backup-$(date +"%Y-%m-%d")"; then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "The setup will be installed in '~/.config/ezsh'\n"
echo -e "Place your personal zshrc config files under '~/.config/ezsh/zshrc/'\n"
mkdir -p ~/.config/ezsh/zshrc

# Places the files found in config into ~/.config/ezsh/zshrc/
cp -r config/* "$HOME/.config/ezsh/zshrc/"

echo -e "Added the following config files:"
ls ~/.config/ezsh/zshrc

if [ -d ~/.quickzsh ]; then
    echo -e "\n PREVIOUS SETUP FOUND AT '~/.quickzsh'. PLEASE MANUALLY MOVE ANY FILES YOU'D LIKE TO '~/.config/ezsh' \n"
fi

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/ezsh/oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
    git -C ~/.config/ezsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
elif [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh in already installed at '~/.oh-my-zsh'. Moving it to '~/.config/ezsh/oh-my-zsh'"
    export ZSH="$HOME/.config/ezsh/oh-my-zsh"
    mv ~/.oh-my-zsh ~/.config/ezsh/oh-my-zsh
    git -C ~/.config/ezsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.config/ezsh/oh-my-zsh
fi

cp -f .zshrc ~/
cp -f ezshrc.zsh ~/.config/ezsh/

mkdir -p ~/.config/ezsh/zshrc # PLACE YOUR ZSHRC CONFIGURATIONS OVER THERE
mkdir -p ~/.cache/zsh/        # this will be used to store .zcompdump zsh completion cache files which normally clutter $HOME
mkdir -p ~/.fonts             # Create .fonts if doesn't exist

if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

if [ -d ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/ezsh/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

# https://github.com/MichaelAquilina/zsh-you-should-use?tab=readme-ov-file#installation
if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-you-should-use ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-you-should-use && git pull
else
    git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ~/.config/ezsh/oh-my-zsh/custom/plugins/zsh-you-should-use
fi

# https://github.com/brymck/print-alias
if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/print-alias ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/print-alias && git pull
else
    git clone --depth=1 https://github.com/brymck/print-alias ~/.config/ezsh/oh-my-zsh/custom/plugins/print-alias
fi

if [ -d ~/.~/.config/ezsh/fzf ]; then
    cd ~/.config/ezsh/fzf && git pull
    ~/.config/ezsh/fzf/install --all --key-bindings --completion --no-update-rc
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/ezsh/fzf
    ~/.config/ezsh/fzf/install --all --key-bindings --completion --no-update-rc
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/k ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k ~/.config/ezsh/oh-my-zsh/custom/plugins/k
fi

if [ -d ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab ]; then
    cd ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab && git pull
else
    git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.config/ezsh/oh-my-zsh/custom/plugins/fzf-tab
fi

if [ -d ~/.config/ezsh/marker ]; then
    cd ~/.config/ezsh/marker && git pull
else
    git clone --depth 1 https://github.com/jotyGill/marker ~/.config/ezsh/marker
fi

if ~/.config/ezsh/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "Marker Installation Had Issues\n"
fi

exit
