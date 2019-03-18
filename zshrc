# Clear all functions and aliases
unhash -mf "*"
unhash -ma "*"
. /etc/zsh/zshrc  # reload standard functions and aliases

export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=120
export PATH=".:$HOME/.dotfiles/bin:./vendor/bin:$HOME/.config/composer/vendor/bin:$PATH"

plugins=(z colored-man-pages)

alias tmux="tmux -2"

ZSH_THEME="af-magic"

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

export TERM=xterm-256color
alias copy="xclip -in -selection clipboard"
alias cgrep="grep --color=always"

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

# Productivity

alias p="pwd"
alias v="vim"
alias r="rm"
alias vs="v ~/.zshrc"
alias vsl="v ~/.zshrc_local"
alias zs="source ~/.zshrc"
alias c="cd"
alias m="make"
alias mt="m test"
alias ms="m start"
alias msp="m stop"
alias mr="m restart"
alias mi="m install"
alias md="m deploy"
alias l="exa"
alias ls="exa"
alias ll="l -lah"

alias g="git"
alias ga="g add"
alias gam="g addm"
alias gau="g addu"
alias gcm="g commit -m"
alias gcma="g commit --amend"
alias gcman="g commit --amend --no-edit"
alias gp="g push"
alias gpf="g push -f"
alias gpu="g push -u"
alias gco="g checkout"
alias gcom="gco master"
alias gcod="gco develop"
alias gcob="gco -b"
alias gco.="gco ."
alias gs="g status"
alias gst="g stash"
alias gsta="gst apply"
alias gstp="gst pop"
alias gdf="g df"
alias gdfc="g dfc"
alias gpl="g pull"
alias grh="g reset --hard"
alias grs="g reset --soft HEAD^"
alias gcl="g clone"
alias glg="g lg"
alias glga="g lga"
alias gbr="g br"
alias grm="g rm"
alias grmc="grm --cached"
alias gr="g rebase"
alias gf="git fetch"
alias gfa="gf --all"
alias gap="gam && gcman && gpf"
alias gsp="zsh -c 'cd ~/Projects && git standup -s -m 2'"
alias pr="hub pull-request -c"
alias git-cleanup="git branch --merged | egrep -v \"(^\*|master|develop)\" | xargs git branch -d"

gb() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

gbd() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git branch -D $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Local delete of branch that was merged in upstream
gld() {
    branch=$(git branch | grep \* | cut -d ' ' -f2)
    git checkout develop
    git pull origin develop
    git br -d $branch
}

code_rtf_file() {
    pygmentize -l $1 -f html -O style=colorful,noclasses=true $2 | xclip -selection clipboard -in  -t text/html
}

code_rtf() {
    xclip -out -selection clipboard | pygmentize -l $1 -f html -O style=colorful,noclasses=true | xclip -selection clipboard -in  -t text/html
}

alias f="docker-compose"
alias d="docker"
alias dm="docker-machine"
alias fe="f exec"
alias fea="f exec api"
alias fep="f exec php"
alias fef="f exec front"
alias fen="f exec nginx"
alias fed="f exec db"
alias few="f exec web"
alias fu="f up"
alias fd="f down"
alias fl="f logs"
alias fr="f run"
alias fp="f ps"
alias sf="fep bin/console"

alias preview="fzf --preview 'bat --color \"always\" {}'"
#alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

alias alacritty_preview='ls .dotfiles/alacritty/colors/* | fzf --preview "docker run -v ${PWD}:/workdir mikefarah/yq yq merge -x -i .dotfiles/config/alacritty/alacritty.yml {}; colortest"'

function mu() {
    if [[ $# -eq 0 ]]; then
        history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n15
    elif [[ $# -eq 1 ]]; then
        history | awk '$2=="'$1'"{CMD[$3]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n15
    elif [[ $# -eq 2 ]]; then
        history | awk '$2=="'$1'"&&$3=="'$2'"{CMD[$4]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n15
    elif [[ $# -eq 3 ]]; then
        history | awk '$2=="'$1'"&&$3=="'$2'"&&$4=="'$3'"{CMD[$5]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n15
    fi
}

source <(kubectl completion zsh)
eval "$(symfony-autocomplete)"
alias watch="$HOME/Projects/watcher/bin/console watch"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

eval $(thefuck --alias)

function chpwd() {
    export PREVIOUS_CONFIG=$CURRENT_CONFIG

    if [ -r $PWD/.zshrc ]; then
        export CURRENT_CONFIG=$PWD/.zshrc
    else
        PROJECT_DIR=$(git rev-parse --show-toplevel 2>/dev/null)

        if [ -r $PROJECT_DIR/.zshrc ]; then
            export CURRENT_CONFIG=$PROJECT_DIR/.zshrc
        else
            export CURRENT_CONFIG=$HOME/.zshrc
        fi
    fi

    if [ "$PREVIOUS_CONFIG" != "$CURRENT_CONFIG" ]; then
        source $CURRENT_CONFIG
    fi
}

