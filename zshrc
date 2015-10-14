export ZSH=$HOME/.oh-my-zsh

alias tmux="tmux -2"
alias latexmk="latexmk -pdf -pvc"

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
