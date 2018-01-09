export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=120

alias tmux="tmux -2"
alias f="fortune | ponysay"

ZSH_THEME="af-magic"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

export TERM=xterm-256color
alias copy="xclip -in -selection clipboard"
alias cgrep="grep --color=always"
alias git-cleanup="git branch --merged | egrep -v \"(^\*|master|develop)\" | xargs git branch -d"
alias make="make -s" # Don't echo commands

function countdown_seconds() {
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

function countdown() {
    countdown_seconds $(($1 * 60))
}

function alarm() {
    countdown $1
    aplay ~/Musique/sonnerie.wav
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
