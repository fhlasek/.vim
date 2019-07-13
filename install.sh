#!/bin/bash

# Exit on error
set -e

# Link vimrc if it does not exist yet
if [ -e "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]; then
  echo "~/.vimrc already exists => not linking it"
else
  ln -s "`pwd`/vimrc" "$HOME/.vimrc"
fi

mkdir -p ~/.vim/bundle
pushd ~/.vim/bundle/

# Pathogen = makes it super easy to install plugins and runtime files
if [ ! -d "vim-pathogen" ]; then
  git clone https://github.com/tpope/vim-pathogen
else
  pushd vim-pathogen
  git pull
  popd
fi

# NerdTree = file system explorer
if [ ! -d "nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree
else
  pushd nerdtree
  git pull
  popd
fi

# Syntastic = syntax checking plugin
if [ ! -d "syntastic" ]; then
  git clone https://github.com/vim-syntastic/syntastic
else
  pushd syntastic
  git pull
  popd
fi

# Airline = status/tabline for vim that's light as air
if [ ! -d "vim-airline" ]; then
  git clone https://github.com/vim-airline/vim-airline
else
  pushd vim-airline
  git pull
  popd
fi

# Airline themes = official themes for vim-airline
if [ ! -d "vim-airline-themes" ]; then
  git clone https://github.com/vim-airline/vim-airline-themes
else
  pushd vim-airline-themes
  git pull
  popd
fi

# Powerline fonts = fonts for usage with the Powerline statusline plugin
if [ ! -d "fonts" ]; then
  git clone https://github.com/powerline/fonts
  pushd fonts
  ./install.sh
  popd
else
  pushd fonts
  git pull
  ./install.sh
  popd
fi

# fugitive.vim = the best Git wrapper of all time
if [ ! -d "vim-fugitive" ]; then
  git clone https://github.com/tpope/vim-fugitive
else
  pushd vim-fugitive
  git pull
  popd
fi

# vim-multiple-cursors = multiple selections similar to Sublime Text
if [ ! -d "vim-multiple-cursors" ]; then
  git clone https://github.com/terryma/vim-multiple-cursors.git
else
  pushd vim-multiple-cursors
  git pull
  popd
fi

# ctrlp.vim = Full path fuzzy file, buffer, mru, tag, ... finder
if [ ! -d "ctrlp.vim" ]; then
  git clone https://github.com/ctrlpvim/ctrlp.vim.git
else
  pushd ctrlp.vim
  git pull
  popd
fi

popd
