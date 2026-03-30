if command -v terraform >/dev/null 2>&1; then
	complete -o nospace -C "$(command -v terraform)" terraform
fi

_load_deferred_completions_once() {
	add-zsh-hook -d preexec _load_deferred_completions_once

	command -v flux >/dev/null && . <(flux completion zsh)

	if [ -r "${HOMEBREW_PREFIX}/share/google-cloud-sdk/path.zsh.inc" ]; then
		source "${HOMEBREW_PREFIX}/share/google-cloud-sdk/path.zsh.inc"
	fi
	if [ -r "${HOMEBREW_PREFIX}/share/google-cloud-sdk/completion.zsh.inc" ]; then
		source "${HOMEBREW_PREFIX}/share/google-cloud-sdk/completion.zsh.inc"
	fi

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
