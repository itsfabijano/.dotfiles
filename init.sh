#!/bin/bash

rm -rf ~/.config/nvim
ln -s $(pwd)/nvim ~/.config/nvim

rm -rf ~/.zshrc
ln -s $(pwd)/zsh/.zshrc ~/.zshrc

rm -rf ~/.tmux.conf
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf

rm -rf ~/.wezterm.lua
ln -s $(pwd)/wezterm/.wezterm.lua ~/.wezterm.lua

rm -rf ~/.config/kitty 
ln -s $(pwd)/kitty ~/.config/kitty
