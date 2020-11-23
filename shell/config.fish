set PATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
set PATH $PATH /home/me/.local/bin
set PATH $PATH /home/me/lopt/pycharm-community-2020.2.3/bin
set PATH $PATH /home/me/lopt/clion-2020.2.4/bin
set PATH $PATH /home/me/lopt/thunderbird

set EDITOR micro
set PAGER most
set BAT_THEME DarkNeon

alias ls="exa -l"
alias ll="exa -l"
alias la="exa -la"
alias lt="exa --tree"

alias cat="bat --pager=never"
alias catp="bat -pp"

alias ugly="ugrep -nrIQZ -e \"\""
alias uglu="ugrep -nrIQ -e \"\""
alias ubin="ugrep -boUX"
alias grep="ugrep -G"
alias egrep="ugrep -E"
alias fgrep="ugrep -F"
alias pgrep="ugrep -P"
alias xgrep="ugrep -W"

alias top="bpytop"
alias htop="bpytop"

alias cp="rsync -v --progress"
alias cpr="rsync -av --progress"

alias gzip="pigz"
alias bzip2="pbzip2"
alias locate="plocate"

alias dc="docker-compose"
alias dclogs="docker-compose logs"
alias dcupd="docker-compose up -d"
alias dcdn="docker-compose down"
alias dcrestart="docker-compose restart"
alias dcpull="docker-compose pull"

alias leave="pkill kitty"
alias tohex="begin; echo 'obase=16;ibase=10'; cat -; end | bc"
alias todec="begin; echo 'obase=10;ibase=16'; cat -; end | bc"
alias sz="du -ch --max-depth=1 | sort -hr"

if not [ "$TMUX" ]
    tmux attach; or tmux
end
