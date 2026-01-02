alias hi="history"
alias c="pbcopy"
alias p="pbpaste"
alias history="history -10000"
alias td="tree -d"
alias tree2="tree -d -L 2"
alias tree3="tree -d -L 3"
alias tree4="tree -d -L 4"

alias cdd="cd `pwd`"

alias gr="rg"
alias g="rg"
alias gi="rg -i"
alias gv="rg -v"
alias gvi="rg -vi"
alias rgo="rg -tgo -F"
alias rgoo="rg -tgo -l -F"
alias rgp="rg -tprotobuf -F"
alias rgy="rg -tyaml -F"
alias rgmd="rg -tmarkdown"
alias rgpy="rg -tpython -F"

alias dir='. ~/bin/dir'

alias bi='vi'
alias ci='vi'
alias vu='vi'
alias vi='nvim -p'

export MYSQL_PS1="local/\d > "

# support colors
export LESS=-RFX

alias ls="ls --color=auto $LS_OPTIONS"
alias l="eza --long --git"
alias ll="logo-ls -l"
alias lsd='ls -ltr'
alias newline="sed -i -e '$a'"
alias less='less -R'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias d="cd ~/Downloads && ls -ltra"
alias diff='colordiff'
alias nodiff='GIT_PAGER='' git diff --no-ext-diff'

alias y2j='yq . -o=json | jless --mode line'
alias yless='jless --yaml'
alias y='jless --yaml'

# golang
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export GOSRC=$GOPATH/src
export PATH=$GOBIN:$PATH
export PATH="/opt/homebrew/opt/go@1.24/bin:$PATH"

# rust
# source $HOME/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"

# python pipx
export PATH="$HOME/.local/bin:$PATH"

export COLORTERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

alias cdg="while true; do [ ! -d .git ] && cd .. || break; done"

eval $(gdircolors -b ~/.LS_COLORS)

# brew stuff
export HOMEBREW_AUTO_UPDATE_SECS=86400
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# java
#export PATH="/usr/local/opt/openjdk/bin:$PATH"
#export JAVA_HOME=$(/usr/libexec/java_home)

function cdgo {
    cd "$GOPATH/src/$1"
}

eval "$(jump shell zsh)"

stty -ixon

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
# if [ -f /Users/gonzalo/go/src/github.com/tetrateio/tetrate/tctl/build/debug/bin/tctl ]; then
    # source <(/Users/gonzalo/go/src/github.com/tetrateio/tetrate/tctl/build/debug/bin/tctl completion zsh)
# fi
function kalpinepod () { kubectl run -it --rm --restart=Never --image=alpine handytools -n ${1:-default} -- /bin/ash }

. $(brew --prefix asdf)/libexec/asdf.sh

export PATH="${PATH}:${HOME}/.krew/bin"

# istio
export PATH="$HOME/.istioctl/bin:$PATH"

# gcloud
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export EDITOR=nvim

autoload +X -Uz _git && _git &>/dev/null
functions[_git-stash]=${functions[_git-stash]//\\_git-notes /}


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$HOME/dev/pulumi/:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/dev/neovim/build/bin:$PATH"
export PATH="$HOME/bin:$PATH"

HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export KUBE_EDITOR=nvim

mkdircd ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

alias codex-yolo="codex --dangerously-bypass-approvals-and-sandbox"
alias claude-yolo="claude --dangerously-skip-permissions"
alias cc="claude --dangerously-skip-permissions"
alias gemini-yolo="gemini --yolo"
alias copilot-yolo="copilot --allow-all-tools"

# source /Users/gonzalo/go/src/github.com/stepan-tikunov/zsh-notify/notify.plugin.zsh

tmp () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

git-wt() {
	local dir=$(command git-wt "$@" | grep "Changed directory" | awk '{print $NF}')
	[ -n "$dir" ] && cd "$dir"
}
