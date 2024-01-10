#!/usr/bin/env bash

# Install brew and brew cask apps                                             #

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

declare -a brew_cli_tools=(
  'ag'
  'age'
  'asdf'
  'bat'
  'cmake'
  'colordiff'
  'coreutils'
  'ctags'
  'difftastic'
  'dos2unix'
  'exa'
  'exiftool'
  'ffmpeg'
  'fzf'
  'git'
  'git-delta'
  'gh'
  'gnu-sed'
  'gnu-tar'
  'graphviz'
  'htop'
  'httpie'
  'hugo'
  'imagemagick'
  'jq'
  'jump'
  'mas'
  'ncdu'
  'parallel'
  'pidcat'
  'rename'
  'ripgrep'
  'shellcheck'
  'tig'
  'tldr'
  'tmux'
  'tree'
  'vim'
  'watch'
  'watchman'
  'zsh'
  'zsh-autosuggestions'
  'zsh-history-substring-search'
  'zsh-syntax-highlighting'
)

for tool in "${brew_cli_tools[@]}"; do
  brew install "$tool"
done


declare -a brew_dev_tools=(
  'node'
  'go'
  'gradle'
  'yarn'
  'sbt'
  'nvm'
)

for tool in "${brew_dev_tools[@]}"; do
  brew install "$tool"
done

# Install Mac App Store apps                                                  #

declare -a mas_apps=(
  '419330170' # Moom
  '1037126344' # Apple configurator
  '497799835' # Xcode
)

for app in "${mas_apps[@]}"; do
  mas install "$app"
done

# Configure installed apps                                                    #

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew tap homebrew/cask-versions homebrew/cask-fonts

declare -a brew_cask_apps=(
  'homebrew/cask-drivers/logitech-options'
  '1password'
  'adobe-creative-cloud'
  'bitbar'
  'charles'
  'cleanshot'
  'docker'
  'dropbox'
  'google-chrome'
  'iterm2'
  'jumpcut'
  'keybase'
  # 'mtmr'
  'notion'
  'skype'
  'slack'
  'spotify'
  'tableplus'
  'the-unarchiver'
  'visual-studio-code'
  'vlc'
  # 'webtorrent'
  # 'whatsapp'
  'zoom'
  'lunar'
  'muzzle'
)

for app in "${brew_cask_apps[@]}"; do
  brew install --cask "$app"
done

