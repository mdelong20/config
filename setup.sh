#!/bin/sh

# ------------------------------------------------------------------------------
#  Install
#    1) Basic package update and setup
#    2) Install Chrome APT source and keys
#    3) Install VSCODE APT source, keys and APT sources file
#    4) Setup configuration files for vim, tmux and bash
#    5) Setup VIM Vundle
#    6) Instll Nerd fonts
#    7) Setup TMUX
# ------------------------------------------------------------------------------
# Initial Package Update and Install
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt upgrade
sudo apt install -y vim tmux git build-essential wget gpg apt-transport-https make gcc ripgrep unzip git xclip neovim

# Install Chrome APT Repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google.gpg >/dev/null
GLIST="/etc/apt/sources.list.d/google.list"
if [ -f ${GLIST} ]; then
    rm ${GLIST}
fi
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> ${GLIST}'
sudo apt-get install google-chrome-stable

# Install VSCODE APT Repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

# Setup VSCODE APT Sources File
VSCODE_LIST="/etc/apt/sources.list.d/vscode.sources"
sudo sh -c "echo \"Types: deb\" > ${VSCODE_LIST}"
sudo sh -c "echo \"URIs: https://packages.microsoft.com/repos/code\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Suites: stable\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Components: main\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Architectures: amd64,arm64,armhf\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Signed-By: /usr/share/keyrings/microsoft.gpg\" >> ${VSCODE_LIST}"

# Install Code
sudo apt install code # or code-insiders

# Copy Configuration Files
cp ./.tmux.conf ~/.tmux.conf
cp ./.vimrc ~/.vimrc
cp ./.bash_aliases ~/.bash_aliases

# Setup VIM Vundle
VIM_INST_D=~/.vim/bundle
VIM_INST=${VIM_INST_D}/Vundle.vim

if [ -d ${VIM_INST_D} ]; then
    rm -rf ${VIM_INST_D}
fi
git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_INST}

# Install Fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh

# Tmux Setup Package Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# NVIM Clone kickstart Configuration -- Considering Forking
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
