function ssh_connection() {
	if [[ -n $SSH_CONNECTION ]]; then
		echo "$fg_bold[white]::: $FG[027](ssh) ";
    else
        echo '';
	fi
}

local statcode="%(?:%{$fg[green]%}:%{$fg[red]%})%?%{$reset_color%}"

PROMPT='$FG[240]
_______________________________________________________________________________
$(ssh_connection)$fg_bold[white]::: $FG[027]%* $fg_bold[white]::: $FG[027]%n@%m $fg_bold[white]::: $FG[027]%~$(git_prompt_info)$(rvm_prompt_info)$reset_color
λ '

RPROMPT="$statcode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="$fg[green]("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN="✓"
ZSH_THEME_GIT_PROMPT_DIRTY="x"
ZSH_THEME_GIT_PROMPT_AHEAD="»"
ZSH_THEME_GIT_PROMPT_BEHIND="«"
