alias v="vagrant"
alias h="history"
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

#export PATH="/usr/local/opt/php55/bin:/Users/gonzalo/bin:$PATH:/Users/gonzalo/erlang/bin"
#export PATH="/usr/local/opt/php55/bin:/Users/gonzalo/bin:$PATH"
alias phpu='mv /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini.2 > /dev/null 2>&1; ./phpunit -c app --stop-on-failure --stop-on-error; mv /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini.2 /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini > /dev/null 2>&1'
alias phpuu='mv /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini.2 > /dev/null 2>&1; phpunit -c app --stop-on-failure --stop-on-error; mv /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini.2 /usr/local/etc/php/5.5/conf.d/ext-xdebug.ini > /dev/null 2>&1'

export SVN_EDITOR="vim --noplugin"
export HOMEBREW_GITHUB_API_TOKEN=1778cd697fd9ec80ff0ac7e4b02cdfefd77a3e84
export GOPATH="/usr/local/go"

source /Users/gonzalo/dev/erlang/releases/r16b03/activate
alias obs='erl -sname observer -run observer -detached'
