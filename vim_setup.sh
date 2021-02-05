#! /usr/bin/env bash

set -euo pipefail

if [ -e ~/.vimrc ]; then
  read -p "You have an existing ~/.vimrc file, would you like to replace it? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
  else
      echo "Replacing existing ~/.vimrc file..."
  fi
fi

if [ -e ~/.vim/bundle/Vundle.vim ]; then
  echo "Vundle already cloned. Skipping this step."
else
  echo "Cloning Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

INSTALL_TO=~/.vimrc

cat ./vimrc > $INSTALL_TO

echo "Done creating ~/.vimrc file and installing dependencies."

