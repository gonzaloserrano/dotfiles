# fork of default's robbyrussell but with a more useful path.

# return full pwd but the parent dirs are abbreviated
# https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/prompt/functions/prompt-pwd
function prompt-pwd {
    setopt localoptions extendedglob

    local current_pwd="${PWD/#$HOME/~}"
    local ret_directory

    if [[ "$current_pwd" == (#m)[/~] ]]; then
      ret_directory="$MATCH"
      unset MATCH
    elif zstyle -m ':prezto:module:prompt' pwd-length 'full'; then
      ret_directory=${PWD}
    elif zstyle -m ':prezto:module:prompt' pwd-length 'long'; then
      ret_directory=${current_pwd}
    else
      ret_directory="${${${${(@j:/:M)${(@s:/:)current_pwd}##.#?}:h}%/}//\%/%%}/${${current_pwd:t}//\%/%%}"
    fi

    unset current_pwd

    print "$ret_directory"
}

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# I have changed this line from the original hubbTODO
PROMPT+=' %{$fg[cyan]%}$(prompt-pwd)%{$reset_color%} $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
