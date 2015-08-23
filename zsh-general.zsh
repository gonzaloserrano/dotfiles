alias v="vagrant"
alias hi="history"
alias c="pbcopy"
alias g="grep"
alias gi="grep -i"
alias gv="grep -v"
alias gvi="grep -vi"
alias t="tail"
alias t1="tail -n 10"
alias t2="tail -n 25"

alias cu="composer.phar update --dev"
alias err="tail -f /var/log/apache2/error_log | sed 's/\\\n//g'"
alias ack="ack -i"
alias ackj="ack -i --js"
alias ackp="ack -i --php"
alias ag="ag -S -p ~/.agignore --pager less -f"
alias agj="ag -S -p ~/.agignore --pager less -f -G '\.js'"
alias ago="ag -S -p ~/.agignore --pager less -f -G '\.go'"
alias agoo="ag -S -p ~/.agignore --ignore-dir Godeps --pager less -f -G '\.go'"
alias agp="ag -S -p ~/.agignore --pager less -f -G '\.php'"
alias age="ag -S -p ~/.agignore --pager less -f -G '\.erl'"
alias agc="ag -S -p ~/.agignore --pager less -f -G '\.yml' -G '\.xml'"
alias cc="app/console cache:clear"
alias dir='. ~/bin/dir'
alias history="history -10000"
alias mysql_start='sudo launchctl start com.mysql.mysql-server'
alias mysql_stop='sudo launchctl stop com.mysql.mysql-server'
alias redis_start='sudo launchctl start io.redis.redis-server'
alias redis_status='redis-cli ping'
alias redis_stop='sudo launchctl stop io.redis.redis-server'
alias services="php app/console container:debug"

alias bi='vi'
alias ci='vi'
# alias vi='nvim -p'
alias vi='vim -p'
alias vin='vim -u NONE -N'

export MYSQL_PS1="local/\d > "

# support colors
export LESS=-RFX

export JAVA_HOME=$(/usr/libexec/java_home)
export WORK_HOME=/Users/gonzalo/wrk

bindkey "f" forward-word
bindkey "b" backward-word
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

bindkey -v
alias ls="/usr/local/bin/gls --color=auto $LS_OPTIONS"
alias l="ls -AFGhl"
alias hl="highlight --syntax php -A --style desert"

alias less='less -R'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias svns='svn status'
alias svnd='svn diff | colordiff'
alias svndi='svn diff --diff-cmd diff -x -uw | colordiff'
alias svnl='svn log | less'
alias svnu='svn update'
alias svnc='svn commit'
alias svnr='svn revert'
alias lsd='ls -ltr'
alias diff='colordiff'
alias gdiff='GIT_PAGER='' git diff --no-ext-diff'
alias gdiffa='GIT_PAGER='' git diff --no-ext-diff | grep -E "^\+.*"'
alias dev='git checkout develop'
alias mas='git checkout master'

export SVN_EDITOR="vim --noplugin"
export HOMEBREW_GITHUB_API_TOKEN=1778cd697fd9ec80ff0ac7e4b02cdfefd77a3e84

alias obs='erl -sname observer -run observer -detached'
alias pom='thyme'
alias b2d='$(boot2docker shellinit)'
alias awss='$(source ~/.aws/source-socialpoint)'
alias awssd='$(source ~/.aws/source-socialpoint-dev)'

alias vend='$(source ~/bin/git-vendor)'

export GOPATH="/Users/gonzalo/dev/sp/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GOROOT=`go env GOROOT`
export GOMAXPROCS=2

export COLORTERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

alias docker-app-bash='docker exec -ti `docker-compose ps -q app | head -n1` bash'
alias docker-app-apache-log='docker exec -ti `docker-compose ps -q app` sh -c "tail -f /var/log/apache2/localhost/error.log"'
alias docker-app-mysql-bash='docker exec -ti `docker-compose ps -q mysql | head -n1` bash'
alias docker-app-redis-cli='docker exec -ti `docker-compose ps -q redis` sh -c "redis-cli"'

. `brew --prefix`/etc/profile.d/z.sh
. ~/.h
