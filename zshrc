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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
