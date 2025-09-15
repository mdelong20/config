#!/bin/sh

# ------------------------------------------------------------------------------
#  Installations
# ------------------------------------------------------------------------------
sudo apt install -y vim tmux git build-essential

# Install Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google.gpg >/dev/null
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Install VSCODE
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

VSCODE_LIST="/etc/apt/sources.list.d/vscode.sources"
sudo sh -c "echo \"Types: deb\" > ${VSCODE_LIST}"
sudo sh -c "echo \"URIs: https://packages.microsoft.com/repos/code\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Suites: stable\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Components: main\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Architectures: amd64,arm64,armhf\" >> ${VSCODE_LIST}"
sudo sh -c "echo \"Signed-By: /usr/share/keyrings/microsoft.gpg\" >> ${VSCODE_LIST}"

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

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
