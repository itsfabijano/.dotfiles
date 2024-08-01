#!/bin/bash
brew install neovim
brew install ripgrep
brew install tmux

# Lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone \
  git@github.com:grigorii-zander/zsh-npm-scripts-autocomplete.git \
  ~/.oh-my-zsh/custom/plugins/zsh-npm-scripts-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

