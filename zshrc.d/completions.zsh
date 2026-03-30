_load_deferred_completions_once() {
	add-zsh-hook -d preexec _load_deferred_completions_once

	complete -o nospace -C "${commands[terraform]}" terraform
	source <(mise completion zsh)
	source <(flux completion zsh)

	unset -f _load_deferred_completions_once
}

# Defer optional tool completions until the first executed command.
if [[ -o interactive ]]; then
	add-zsh-hook preexec _load_deferred_completions_once
else
	_load_deferred_completions_once
fi

# Initialize completions after all fpath modifications are complete
autoload -Uz compinit && compinit
