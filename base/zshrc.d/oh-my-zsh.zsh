typeset -gx ZSH=$HOME/.oh-my-zsh
typeset -gx ZSH_THEME=cloud
typeset -gx COMPLETION_WAITING_DOTS=true
plugins=(
	git
	docker
	docker-compose
)
source $ZSH/oh-my-zsh.sh
