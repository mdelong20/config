#!/bin/sh

# ------------------------------------------------------------------------------
#  Installations
# ------------------------------------------------------------------------------
sudo apt install -y vim tmux git build-essential

# Stage Configuration Files
cp ./.tmux.conf ~/.tmux.conf
cp ./.vimrc ~/.vimrc
cp ./.bash_aliases ~/.bash_aliases

# Setup VIM
VINST_D=~/.vim/bundle
VINST=${VINST_D}/Vundle.vim

if [ -d ${VINST_D} ]; then
    rm -rf ${VINST_D}
fi
git clone https://github.com/VundleVim/Vundle.vim.git ${VINST}

# Install Fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh