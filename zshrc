# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/Users/gonzalo/.zshrc'
autoload -Uz compinit
compinit

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT

#{{{ History Stuff

# Where it gets saved
HISTFILE=~/.history

# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Write after each command
# setopt INC_APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

#}}}


bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

bindkey -v

# brew custom aliases
brew_prefix=`brew --prefix`
source /usr/local/Cellar/coreutils/8.7/aliases
alias l="$brew_prefix/bin/gls -l"
alias ls="$brew_prefix/bin/gls --color=auto $LS_OPTIONS"

# PEAR
alias pear="$brew_prefix/bin/pear"
alias peardev="$brew_prefix/bin/peardev"
alias pecl="$brew_prefix/bin/pecl"

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
alias go='. go'
alias lsd='ls -ltr'
alias diff='colordiff'
alias bi='vi'
alias ci='vi'
alias vip='vi -p'

alias gdiff='GIT_PAGER='' git diff --no-ext-diff'
alias gdiffa='GIT_PAGER='' git diff --no-ext-diff | grep -E "^\+.*"'

eval `dircolors ~/.dir_colors`

export PATH="$PATH:/Users/gonzalo/bin/"
function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    local mygit=$(get_git_prompt_info)
    local gitsize=${#${mygit}}+1
    
    if [[ "$promptsize + $pwdsize + $gitsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize - $gitsize))
    else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize + $gitsize)))..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    #if which ibam > /dev/null; then
	#PR_APM_RESULT=`ibam --percentbattery`
    #elif which apm > /dev/null; then
	#PR_APM_RESULT=`apm`
    #fi
}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLACK MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    
    ###
    # Decide if we need to set titlebar text.
    
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi
    
    
    ###
    # APM detection
    
    if which ibam > /dev/null; then
	PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLACK:'
    elif which apm > /dev/null; then
	PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLACK:'
    else
	PR_APM=''
    fi
    
    
    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_WHITE$PR_SHIFT_IN$PR_ULCORNER$PR_WHITE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<$PR_WHITE)\
$(get_git_prompt_info)\
:$PR_SHIFT_IN$PR_HBAR$PR_WHITE$PR_HBAR${(e)PR_FILLBAR}$PR_WHITE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_WHITE)$PR_SHIFT_IN$PR_HBAR$PR_WHITE$PR_URCORNER$PR_SHIFT_OUT\

$PR_WHITE$PR_SHIFT_IN$PR_LLCORNER$PR_WHITE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_WHITE:)\
${(e)PR_APM}$PR_YELLOW%D{%H:%M}\
$PR_LIGHT_WHITE:%(!.$PR_RED.$PR_WHITE)%#$PR_WHITE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR '

    RPROMPT=' $PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_WHITE$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%a, %d %b}$PR_WHITE)$PR_SHIFT_IN$PR_HBAR$PR_WHITE$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

    PS2='$PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_WHITE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt

export SVN_EDITOR="vim --noplugin"

# echo -e "#brew_aliases\n\n" >> ~/.zshrc; for i in `ls /usr/local/bin | grep -v brew`; do echo "alias $i=\"\$brew_prefix/bin/$i\"" >> ~/.zshrc; done;
brew_prefix=`brew --prefix`

#brew_aliases

alias Magick-config="$brew_prefix/bin/Magick-config"
alias MagickCore-config="$brew_prefix/bin/MagickCore-config"
alias MagickWand-config="$brew_prefix/bin/MagickWand-config"
alias Wand-config="$brew_prefix/bin/Wand-config"
alias animate="$brew_prefix/bin/animate"
alias bmp2tiff="$brew_prefix/bin/bmp2tiff"
alias cdiff="$brew_prefix/bin/cdiff"
alias cjpeg="$brew_prefix/bin/cjpeg"
alias colordiff="$brew_prefix/bin/colordiff"
alias compare="$brew_prefix/bin/compare"
alias composite="$brew_prefix/bin/composite"
alias conjure="$brew_prefix/bin/conjure"
alias convert="$brew_prefix/bin/convert"
alias csshX="$brew_prefix/bin/csshX"
alias ctags="$brew_prefix/bin/ctags"
alias display="$brew_prefix/bin/display"
alias djpeg="$brew_prefix/bin/djpeg"
alias erb="$brew_prefix/bin/erb"
alias fax2ps="$brew_prefix/bin/fax2ps"
alias fax2tiff="$brew_prefix/bin/fax2tiff"
alias gbase64="$brew_prefix/bin/gbase64"
alias gbasename="$brew_prefix/bin/gbasename"
alias gcat="$brew_prefix/bin/gcat"
alias gchcon="$brew_prefix/bin/gchcon"
alias gchgrp="$brew_prefix/bin/gchgrp"
alias gchmod="$brew_prefix/bin/gchmod"
alias gchown="$brew_prefix/bin/gchown"
alias gchroot="$brew_prefix/bin/gchroot"
alias gcksum="$brew_prefix/bin/gcksum"
alias gcomm="$brew_prefix/bin/gcomm"
alias gcp="$brew_prefix/bin/gcp"
alias gcsplit="$brew_prefix/bin/gcsplit"
alias gcut="$brew_prefix/bin/gcut"
alias gdate="$brew_prefix/bin/gdate"
alias gdd="$brew_prefix/bin/gdd"
alias gdf="$brew_prefix/bin/gdf"
alias gdir="$brew_prefix/bin/gdir"
alias gdircolors="$brew_prefix/bin/gdircolors"
alias gdirname="$brew_prefix/bin/gdirname"
alias gdu="$brew_prefix/bin/gdu"
alias gecho="$brew_prefix/bin/gecho"
alias gem="$brew_prefix/bin/gem"
alias genv="$brew_prefix/bin/genv"
alias gexpand="$brew_prefix/bin/gexpand"
alias gexpr="$brew_prefix/bin/gexpr"
alias gfactor="$brew_prefix/bin/gfactor"
alias gfalse="$brew_prefix/bin/gfalse"
alias gfmt="$brew_prefix/bin/gfmt"
alias gfold="$brew_prefix/bin/gfold"
alias ggroups="$brew_prefix/bin/ggroups"
alias ghead="$brew_prefix/bin/ghead"
alias ghostid="$brew_prefix/bin/ghostid"
alias gid="$brew_prefix/bin/gid"
alias gif2tiff="$brew_prefix/bin/gif2tiff"
alias ginstall="$brew_prefix/bin/ginstall"
alias git="$brew_prefix/bin/git"
alias git-cvsserver="$brew_prefix/bin/git-cvsserver"
alias git-p4="$brew_prefix/bin/git-p4"
alias git-receive-pack="$brew_prefix/bin/git-receive-pack"
alias git-shell="$brew_prefix/bin/git-shell"
alias git-upload-archive="$brew_prefix/bin/git-upload-archive"
alias git-upload-pack="$brew_prefix/bin/git-upload-pack"
alias gitk="$brew_prefix/bin/gitk"
alias gjoin="$brew_prefix/bin/gjoin"
alias gkill="$brew_prefix/bin/gkill"
alias glink="$brew_prefix/bin/glink"
alias gln="$brew_prefix/bin/gln"
alias glogname="$brew_prefix/bin/glogname"
alias gls="$brew_prefix/bin/gls"
alias gmd5sum="$brew_prefix/bin/gmd5sum"
alias gmkdir="$brew_prefix/bin/gmkdir"
alias gmkfifo="$brew_prefix/bin/gmkfifo"
alias gmknod="$brew_prefix/bin/gmknod"
alias gmktemp="$brew_prefix/bin/gmktemp"
alias gmv="$brew_prefix/bin/gmv"
alias gnice="$brew_prefix/bin/gnice"
alias gnl="$brew_prefix/bin/gnl"
alias gnohup="$brew_prefix/bin/gnohup"
alias gnproc="$brew_prefix/bin/gnproc"
alias god="$brew_prefix/bin/god"
alias gpaste="$brew_prefix/bin/gpaste"
alias gpathchk="$brew_prefix/bin/gpathchk"
alias gpinky="$brew_prefix/bin/gpinky"
alias gpr="$brew_prefix/bin/gpr"
alias gprintenv="$brew_prefix/bin/gprintenv"
alias gprintf="$brew_prefix/bin/gprintf"
alias gptx="$brew_prefix/bin/gptx"
alias gpwd="$brew_prefix/bin/gpwd"
alias greadlink="$brew_prefix/bin/greadlink"
alias grm="$brew_prefix/bin/grm"
alias grmdir="$brew_prefix/bin/grmdir"
alias gruncon="$brew_prefix/bin/gruncon"
alias gseq="$brew_prefix/bin/gseq"
alias gsha1sum="$brew_prefix/bin/gsha1sum"
alias gsha224sum="$brew_prefix/bin/gsha224sum"
alias gsha256sum="$brew_prefix/bin/gsha256sum"
alias gsha384sum="$brew_prefix/bin/gsha384sum"
alias gsha512sum="$brew_prefix/bin/gsha512sum"
alias gshred="$brew_prefix/bin/gshred"
alias gshuf="$brew_prefix/bin/gshuf"
alias gsleep="$brew_prefix/bin/gsleep"
alias gsort="$brew_prefix/bin/gsort"
alias gsplit="$brew_prefix/bin/gsplit"
alias gstat="$brew_prefix/bin/gstat"
alias gstty="$brew_prefix/bin/gstty"
alias gsum="$brew_prefix/bin/gsum"
alias gsync="$brew_prefix/bin/gsync"
alias gtac="$brew_prefix/bin/gtac"
alias gtail="$brew_prefix/bin/gtail"
alias gtee="$brew_prefix/bin/gtee"
alias gtest="$brew_prefix/bin/gtest"
alias gtimeout="$brew_prefix/bin/gtimeout"
alias gtouch="$brew_prefix/bin/gtouch"
alias gtr="$brew_prefix/bin/gtr"
alias gtrue="$brew_prefix/bin/gtrue"
alias gtruncate="$brew_prefix/bin/gtruncate"
alias gtsort="$brew_prefix/bin/gtsort"
alias gtty="$brew_prefix/bin/gtty"
alias guname="$brew_prefix/bin/guname"
alias gunexpand="$brew_prefix/bin/gunexpand"
alias guniq="$brew_prefix/bin/guniq"
alias gunlink="$brew_prefix/bin/gunlink"
alias guptime="$brew_prefix/bin/guptime"
alias gusers="$brew_prefix/bin/gusers"
alias gvdir="$brew_prefix/bin/gvdir"
alias gwc="$brew_prefix/bin/gwc"
alias gwho="$brew_prefix/bin/gwho"
alias gwhoami="$brew_prefix/bin/gwhoami"
alias gyes="$brew_prefix/bin/gyes"
alias highlight="$brew_prefix/bin/highlight"
alias icc2ps="$brew_prefix/bin/icc2ps"
alias icclink="$brew_prefix/bin/icclink"
alias icctrans="$brew_prefix/bin/icctrans"
alias identify="$brew_prefix/bin/identify"
alias imgcmp="$brew_prefix/bin/imgcmp"
alias imginfo="$brew_prefix/bin/imginfo"
alias import="$brew_prefix/bin/import"
alias irb="$brew_prefix/bin/irb"
alias jasper="$brew_prefix/bin/jasper"
alias jpegtran="$brew_prefix/bin/jpegtran"
alias links="$brew_prefix/bin/links"
alias mogrify="$brew_prefix/bin/mogrify"
alias montage="$brew_prefix/bin/montage"
alias pal2rgb="$brew_prefix/bin/pal2rgb"
alias pear="$brew_prefix/bin/pear"
alias peardev="$brew_prefix/bin/peardev"
alias pecl="$brew_prefix/bin/pecl"
alias ppm2tiff="$brew_prefix/bin/ppm2tiff"
alias rake="$brew_prefix/bin/rake"
alias ras2tiff="$brew_prefix/bin/ras2tiff"
alias raw2tiff="$brew_prefix/bin/raw2tiff"
alias rdjpgcom="$brew_prefix/bin/rdjpgcom"
alias rdoc="$brew_prefix/bin/rdoc"
alias rgb2ycbcr="$brew_prefix/bin/rgb2ycbcr"
alias ri="$brew_prefix/bin/ri"
alias ruby="$brew_prefix/bin/ruby"
alias stream="$brew_prefix/bin/stream"
alias testrb="$brew_prefix/bin/testrb"
alias thumbnail="$brew_prefix/bin/thumbnail"
alias tiff2bw="$brew_prefix/bin/tiff2bw"
alias tiff2pdf="$brew_prefix/bin/tiff2pdf"
alias tiff2ps="$brew_prefix/bin/tiff2ps"
alias tiff2rgba="$brew_prefix/bin/tiff2rgba"
alias tiffcmp="$brew_prefix/bin/tiffcmp"
alias tiffcp="$brew_prefix/bin/tiffcp"
alias tiffcrop="$brew_prefix/bin/tiffcrop"
alias tiffdither="$brew_prefix/bin/tiffdither"
alias tiffdump="$brew_prefix/bin/tiffdump"
alias tiffinfo="$brew_prefix/bin/tiffinfo"
alias tiffmedian="$brew_prefix/bin/tiffmedian"
alias tiffset="$brew_prefix/bin/tiffset"
alias tiffsplit="$brew_prefix/bin/tiffsplit"
alias tmrdemo="$brew_prefix/bin/tmrdemo"
alias wrjpgcom="$brew_prefix/bin/wrjpgcom"
alias wtpt="$brew_prefix/bin/wtpt"

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

export __CURRENT_GIT_BRANCH=
export __CURRENT_GIT_VARS_INVALID=1

zsh_git_invalidate_vars() {
    export __CURRENT_GIT_VARS_INVALID=1
}
zsh_git_compute_vars() {
    export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
    export __CURRENT_GIT_VARS_INVALID=
}

parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

chpwd_functions+='zsh_git_chpwd_update_vars'
zsh_git_chpwd_update_vars() {
    zsh_git_invalidate_vars
}

preexec_functions+='zsh_git_preexec_update_vars'
zsh_git_preexec_update_vars() {
    case "$(history $HISTCMD)" in 
            *git*) zsh_git_invalidate_vars ;;
    esac
}

get_git_prompt_info() {
    test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
    echo "<$__CURRENT_GIT_BRANCH>"
}
