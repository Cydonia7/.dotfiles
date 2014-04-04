export ZSH=$HOME/.oh-my-zsh

alias tmux="tmux -2"

ZSH_THEME="af-magic"
plugins=(git)

source $ZSH/oh-my-zsh.sh

EDITOR="vim"

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
