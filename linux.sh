#!/bin/sh

# install
sudo apt update
sudo apt install -y \
  vim \
  openssh-server \
  git-lfs \
  tmux \
  zsh

# ssh
ssh-keygen -t rsa -b 4096
touch ~/.ssh/authorized_keys

# tmux
ln -sf ${PWD}/dotfiles/.tmux.conf ~/.tmux.conf

# zsh
chsh -s $(which zsh) ${USER}
ln -sf ${PWD}/dotfiles/.zshrc ~/.zshrc
ln -sf ${PWD}/dotfiles/.p10k.zsh ~/.p10k.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# vim
ln -sf ${PWD}/dotfiles/.vimrc ~/.vimrc

# git
ln -sf ${PWD}/dotfiles/.gitignore_global ~/.gitignore_global
echo '[core]' >>~/.gitconfig
echo '    excludesfile = ~/.gitignore_global' >>~/.gitconfig
