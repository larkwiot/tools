set PATH /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin
set PATH $PATH /home/me/.local/bin
set PATH $PATH /home/me/.cargo/bin
set PATH $PATH /home/me/.local/bin/crystal/bin
set PATH $PATH /home/me/lopt/thunderbird
set PATH $PATH /home/me/lopt/minecraft-launcher
set PATH $PATH /opt/010editor

set -x DENO_INSTALL /home/me/.deno
set PATH $PATH $DENO_INSTALL/bin
set DENO_DIR /home/me/.deno/cache

set -x EDITOR micro
set -x PAGER most
set -x BAT_THEME DarkNeon

alias ls="ls -lh --color=always"
alias ll="exa -l"
alias la="ls -la --color=always"
alias lt="exa --tree"
alias lf="ls -f1"

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
alias builddb="sudo updatedb && sudo plocate-build /var/lib/mlocate/mlocate.db /var/lib/mlocate/plocate.db"

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
alias start_libvirt="sudo libvirtd -d -v && sudo virtlogd -d -v"

set -x fish_features stderr-nocaret
source /home/me/Repos/spack/share/spack/setup-env.fish

starship init fish | source

if not [ "$TMUX" ]
    tmux attach; or tmux
end
