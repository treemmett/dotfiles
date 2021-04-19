export PATH=$HOME/.bin:$PATH
export ZSH="/home/treemmett/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

alias wp="feh --bg-fill -z ~/Pictures/wallpapers"
alias vi="vim"
alias geth="geth --datadir /data/ethereum"
alias mine="~/scripts/mine-start.sh"
alias cgit="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias npm="pnpm"
