#!/bin/bash

# Exit on error
set -e

VIM_VERSION=`vim --version`
if [[ $VIM_VERSION =~ "VIM - Vi IMproved 8" ]]; then
  echo "Vim version is fine."
else
  echo "Vim 8 has to be installed."
  exit 1
fi

pushd ~/.vim/bundle/

# YouCompleteMe = as-you-type, fuzzy-search code completion engine
if [ ! -d "YouCompleteMe" ]; then
  git clone https://github.com/Valloric/YouCompleteMe.git
  pushd YouCompleteMe
  git submodule update --init --recursive
  ./install.py --clang-completer
  ln -s third_party/ycmd/cpp/ycm/.ycm_extra_conf.py ~/.ycm_extra_conf.py
  popd
else
  pushd YouCompleteMe
  git pull
  git submodule update --recursive
  ./install.py --clang-completer
  popd
fi

popd
