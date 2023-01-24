export PATH="$HOME/bin:$PATH"

alias hi="history"
alias c="pbcopy"
alias p="pbpaste"
alias history="history -10000"
alias td="tree -d"
alias tree2="tree -d -L 2"
alias tree3="tree -d -L 3"
alias tree4="tree -d -L 4"

alias gr="rg"
alias g="rg"
alias gi="rg -i"
alias gv="rg -v"
alias gvi="rg -vi"
alias rgo="rg -tgo"
alias rgoo="rg -tgo -l"
alias rgp="rg -tprotobuf"
alias rgy="rg -tyaml"
alias rgmd="rg -tmarkdown"

alias dir='. ~/bin/dir'

alias bi='vi'
alias ci='vi'
alias vu='vi'
alias vi='nvim -p'
# alias vi='lvim -p'
# alias vin='vim -u NONE -N'
# alias vih='/opt/homebrew/bin/vi'

export MYSQL_PS1="local/\d > "

# support colors
export LESS=-RFX

alias ls="ls --color=auto $LS_OPTIONS"
alias l="exa --long --git"
alias ll="logo-ls -l"
alias lsd='ls -ltr'
alias newline="sed -i -e '$a'"
alias less='less -R'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias diff='colordiff'
alias nodiff='GIT_PAGER='' git diff --no-ext-diff'

alias y2j='yq . -o=json | jless --mode line'
alias yless='jless --yaml'

# golang
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export PATH=$GOBIN:$PATH

# rust
source $HOME/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"

export COLORTERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

alias docker-app-bash='docker exec -ti `docker-compose ps -q app | head -n1` bash'
alias cdg="while true; do [ ! -d .git ] && cd .. || break; done"

eval $(gdircolors -b ~/.LS_COLORS)

# Base16 Shell
#BASE16_SHELL=$HOME/.config/base16-shell/
#[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
#base16_default-dark

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

# export PATH="$HOME/dev/flutter/bin:$PATH"
# export PATH="$HOME/.fastlane/bin:$PATH"
# export PATH="$HOME/Library/Python/2.7/bin:$PATH"

# ruby: rbenv init
# eval "$(rbenv init -)"

# brew stuff
export HOMEBREW_AUTO_UPDATE_SECS=86400
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"

# java
#export PATH="/usr/local/opt/openjdk/bin:$PATH"
#export JAVA_HOME=$(/usr/libexec/java_home)

# haskell compiles programs here
export PATH="/Users/gonzalo/.local/bin:$PATH"

alias tjc="tj -template Color -scale GreenToGreenToRed -delta-buffer"

function cdgo {
    cd "$GOPATH/src/$1"
}

eval "$(jump shell zsh)"

stty -ixon

# . $(brew --prefix asdf)/asdf.sh

export PATH="/Users/gonzalo/dev/git-fuzzy/bin:$PATH"

export ZSH_DISABLE_COMPFIX=true

# k8s

alias k="kubectl"
alias kn="kubectl neat"
alias kk="kubecolor"
alias ki="kubectl -n istio-system"
alias kki="kubecolor -n istio-system"
alias kb="kubectl -n tsb"
alias kkb="kubecolor -n tsb"
alias baty="bat -l yaml"
alias by="bat -l yaml"
source <(kubectl completion zsh)
complete -F __start_kubectl k
if [ -f /Users/gonzalo/go/src/github.com/tetrateio/tetrate/tctl/build/debug/bin/tctl ]; then
    source <(/Users/gonzalo/go/src/github.com/tetrateio/tetrate/tctl/build/debug/bin/tctl completion zsh)
fi
function kalpinepod () { kubectl run -it --rm --restart=Never --image=alpine handytools -n ${1:-default} -- /bin/ash }

export PATH="${PATH}:${HOME}/.krew/bin"
alias kip="kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'"

# go 1.16
export PATH="/opt/homebrew/opt/go@1.16/bin:$PATH"

# istio
# export PATH="$PATH:/Users/gonzalo/istio-1.4.8/bin"
export PATH="$HOME/.istioctl/bin:$PATH"
source "$HOME/Dropbox/mac/conf/configs/_istioctl"

# gcloud
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export EDITOR=vim

autoload +X -Uz _git && _git &>/dev/null
functions[_git-stash]=${functions[_git-stash]//\\_git-notes /}


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$HOME/dev/pulumi/:$PATH"

# export CDPATH=$GOPATH/src/github.com/:$CDPATH

export PATH="$HOME/dev/neovim/build/bin:$PATH"

HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
