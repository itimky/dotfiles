typeset -xr ZSH=$HOME/.oh-my-zsh
typeset -xr ZSH_THEME=cloud
typeset -x COMPLETION_WAITING_DOTS=true
plugins=(
	git
	docker
	docker-compose
)
source $ZSH/oh-my-zsh.sh
