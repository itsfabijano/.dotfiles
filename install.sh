#!/bin/bash
brew install neovim
brew install ripgrep
brew install tmux
brew install fzf
brew install nvm
brew install tree
brew install bat
brew install --cask wezterm
brew install stow
brew install fd
brew install --cask nikitabobko/tap/aerospace

# Fonts
brew install font-meslo-lg-nerd-font
brew install font-roboto-mono-nerd-font

# Lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone \
  git@github.com:grigorii-zander/zsh-npm-scripts-autocomplete.git \
  ~/.oh-my-zsh/custom/plugins/zsh-npm-scripts-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Kitty Terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
