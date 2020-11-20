set -x PATH $PATH:/home/me/.local/bin
set -x PATH $PATH:/home/me/lopt/pycharm-community-2020.2.3/bin
set -x PATH $PATH:/home/me/lopt/clion-2020.2.4/bin
set -x PATH $PATH:/home/me/lopt/thunderbird

set -x EDITOR /bedrock/cross/bin/micro
set -x PAGER /bedrock/cross/bin/most
set -x BAT_THEME DarkNeon

alias ls="exa -l"
alias ll="exa -l"
alias la="exa -la"
alias lt="exa --tree"

alias cat="bat --pager=never"
alias catp="bat -pp"

alias dc="docker-compose"
alias dclogs="docker-compose logs"
alias dcupd="docker-compose up -d"
alias dcdn="docker-compose down"
alias dcrestart="docker-compose restart"
alias dcpull="docker-compose pull"

alias ugly="ugrep -nrIQZ -e \"\""

alias top="bpytop"
alias htop="bpytop"

alias wget="wget2 --progress bar --https-enforce soft"

alias cp="rsync -v --progress"
alias cpr="rsync -av --progress"

alias gzip="pigz"
alias bzip2="pbzip2"
alias locate="plocate"

alias leave="pkill alacritty"
alias tohex="begin; echo 'obase=16;ibase=10'; cat -; end | bc"
alias todec="begin; echo 'obase=10;ibase=16'; cat -; end | bc"
alias sz="du -ch --max-depth=1 | sort -hr"
alias su="sort -u"

if not [ "$TMUX" ]
    tmux attach; or tmux
end
