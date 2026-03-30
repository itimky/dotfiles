complete -o nospace -C /opt/homebrew/bin/terraform terraform

_load_deferred_completions_once() {
	add-zsh-hook -d preexec _load_deferred_completions_once

	command -v flux >/dev/null && . <(flux completion zsh)

	if [ -r "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc" ]; then
		source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
	fi
	if [ -r "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc" ]; then
		source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
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
