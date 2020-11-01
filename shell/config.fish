set -x PATH $PATH:/home/me/.local/bin

alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias lt="exa --tree"

alias cat="bat"

alias dc="docker-compose"
alias dclogs="docker-compose logs"
alias dcupd="docker-compose up -d"
alias dcdn="docker-compose down"
alias dcrestart="docker-compose restart"

alias ugly="ugrep -nrIQZ -e \"\""

if not [ "$TMUX" ]
    exec tmux && exit
end
