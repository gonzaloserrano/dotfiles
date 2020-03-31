#!/usr/bin/env bash

###############################################################################
# Install brew and brew cask apps                                             #
###############################################################################

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add older versions cask repository because of 1Password subscription based business model change from v6 to v7

brew tap homebrew/cask-versions homebrew/cask-fonts

declare -a brew_cask_apps=(
  'adobe-creative-cloud'
  'android-file-transter'
  'android-studio'
  'appcleaner'
  'bartender'
  'betterzip'
  'caffeine'
  'calibre'
  'charles'
  'colorpicker-skalacolor'
  'contexts'
  'docker'
  'dropbox'
  'firefox'
  'google-chrome'
  'google-nik-collection'
  'homebrew/cask-fonts/font-hasklig'
  'imagealpha'
  'istat-menus'
  'iterm2-beta'
  'java'
  'jumpcut'
  'keybase'
  'kitematic'
  'licecap'
  'notion'
  'postman'
  'qlcolorcode'
  'qlmarkdown'
  'qlstephen'
  'qlvideo'
  'quicklook-json'
  'sequel-pro'
  'sketchbook'
  'skype'
  'slack'
  'spotify'
  'suspicious-package'
  'the-unarchiver'
  'transmit'
  'visual-studio-code'
  'vlc'
  'webpquicklook'
  'webtorrent'
  'whatsapp'
)

for app in "${brew_cask_apps[@]}"; do
  brew cask install "$app"
done

declare -a brew_cli_tools=(
  'ack'
  'ag'
  'bat'
  'cmake'
  'colordiff'
  'composer'
  'coreutils'
  'ctags'
  'dos2unix'
  'exiftool'
  'ffmpeg'
  'fzf'
  'git'
  'gnu-sed'
  'gnu-tar'
  'go'
  'gradle'
  'graphviz'
  'htop'
  'httpie'
  'hub'
  'hugo'
  'icdiff' # columnar diff
  'imagemagick'
  'jq'
  'jump'
  'mas'
  'ncdu'
  'node'
  'nvm'
  'parallel'
  'php'
  'pidcat'
  'ripgrep'
  'sbt'
  'terraform'
  'tig'
  'tldr'
  'tmux'
  'tree'
  'vim'
  'watchman'
  'yarn'
  'youtube-dl'
  'zsh'
  'zsh-autosuggestions'
  'zsh-history-substring-search'
  'zsh-syntax-highlighting'
)

for tool in "${brew_cli_tools[@]}"; do
  brew install "$tool"
done

###############################################################################
# Install Mac App Store apps                                                  #
###############################################################################

declare -a mas_apps=(
  '419330170' # Moom
  '1037126344' # Apple configurator
  '497799835' # Xcode
)

for app in "${mas_apps[@]}"; do
  mas install "$app"
done

###############################################################################
# Configure installed apps                                                    #
###############################################################################

# Set ZSH as the default shell
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
