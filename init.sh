#!/bin/bash

rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim
cp $(pwd)/zsh/.zshrc ~/.zshrc
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf
