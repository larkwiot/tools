set -x PATH $PATH:/home/me/.local/bin
set -x PATH $PATH:/home/me/lopt/pycharm-community-2020.2.3/bin
set -x PATH $PATH:/home/me/lopt/clion-2020.2.4/bin

alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias lt="exa --tree"

alias cat="bat --pager=never"

alias dc="docker-compose"
alias dclogs="docker-compose logs"
alias dcupd="docker-compose up -d"
alias dcdn="docker-compose down"
alias dcrestart="docker-compose restart"
alias dcpull="docker-compose pull"

alias ugly="ugrep -nrIQZ -e \"\""

if not [ "$TMUX" ]
    exec tmux && exit
end
