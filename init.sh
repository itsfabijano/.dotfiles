#!/bin/bash

rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim

rm -rf ~/.zshrc
ln -s $(pwd)/zsh/.zshrc ~/.zshrc

rm -rf ~/.tmux.conf
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf
