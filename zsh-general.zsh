alias hi="history"
alias c="pbcopy"
alias t="tail"
alias t1="tail -n 10"
alias t2="tail -n 25"
alias history="history -10000"
alias tree2="tree -d -L 2"
alias tree3="tree -d -L 3"
alias tree4="tree -d -L 4"

alias gr="rg"
alias g="rg"
alias gi="rg -i"
alias gv="rg -v"
alias gvi="rg -vi"
alias rgo="rg -g '!vendor/' -tgo"
alias rgov="rg -tgo"
alias rjs="rg -g '!node_modules/' -tjs"
alias rjsv="rg -tjs"
alias rclj="rg -g '!vendor/' -tclojure"
alias rcljv="rg -tclojure"

alias dir='. ~/bin/dir'

alias bi='vi'
alias ci='vi'
#alias vi='nvim -p'
alias vi='vim -p'
alias vin='vim -u NONE -N'

export MYSQL_PS1="local/\d > "

# support colors
export LESS=-RFX

export JAVA_HOME=$(/usr/libexec/java_home)

alias ls="ls --color=auto $LS_OPTIONS"
alias l="ls -AFGhl"
alias lsd='ls -ltr'
alias hl="highlight --syntax php -A --style desert"
alias newline="sed -i -e '$a'"
alias less='less -R'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias diff='colordiff'
alias gdiff='GIT_PAGER='' git diff --no-ext-diff'
alias gdiffa='GIT_PAGER='' git diff --no-ext-diff | grep -E "^\+.*"'

# golang
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export PATH=$GOBIN:$PATH
alias shadow='go tool vet --shadow .'

# rust
source $HOME/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"

export COLORTERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

alias docker-app-bash='docker exec -ti `docker-compose ps -q app | head -n1` bash'
alias vi='vim -p'
alias cdg="while true; do [ ! -d .git ] && cd .. || break; done"

# Base16 Shell

export PATH="$HOME/bin:$PATH"
eval $(gdircolors -b ~/configs/LS_COLORS)
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_default-dark

bindkey "f" forward-word
bindkey "b" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export NVM_DIR="$HOME/.nvm"
export NVM_SH="/usr/local/opt/nvm/nvm.sh"
# . "${NVM_SH}"

# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "${NVM_SH}" ] && [ ! "$(whence -w __init_nvm)" = function ]; then
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "${NVM_SH}"
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi


#EMBIN=$(whence -p emulator)
#EMBIN=$(realpath $EMBIN)
#EMBIN=$(dirname $EMBIN)
function emulator {
    ( cd "/usr/local/share/android-sdk/tools" && ./emulator "$@"; )
}
alias pixel="emulator -avd pixel26"
alias devs="instruments -s devices"

# android
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH="$ANDROID_HOME/tools:$PATH"
# export PATH="$ANDROID_HOME/platform-tools:$PATH"

export PATH="$HOME/dev/flutter/bin:$PATH"
# export PATH="$HOME/.fastlane/bin:$PATH"
# export PATH="$HOME/Library/Python/2.7/bin:$PATH"

# ruby: rbenv init
# eval "$(rbenv init -)"

# brew stuff
export HOMEBREW_AUTO_UPDATE_SECS=86400
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# haskell compiles programs here
export PATH="/Users/gonzalo/.local/bin:$PATH"

alias tjc="tj -template Color -scale GreenToGreenToRed -delta-buffer"

# php
# export PATH="$(brew --prefix homebrew/php/php72)/bin:$PATH"

function cdgo {
    cd "$GOPATH/src/$1"
}

eval "$(jump shell zsh)"

stty -ixon
