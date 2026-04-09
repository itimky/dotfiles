_load_deferred_completions_once() {
	add-zsh-hook -d preexec _load_deferred_completions_once

	[[ -n "$commands[terraform]" ]] && complete -o nospace -C "${commands[terraform]}" terraform
	[[ -n "$commands[mise]" ]] && source <(mise completion zsh)
	[[ -n "$commands[flux]" ]] && source <(flux completion zsh)

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
