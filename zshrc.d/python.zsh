export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

if command -v pyenv >/dev/null; then
	# Initialize pyenv shell integration only when the pyenv command is first used.
	pyenv() {
		unset -f pyenv
		eval "$(command pyenv init -)"
		eval "$(command pyenv virtualenv-init -)"
		pyenv "$@"
	}
fi

export PATH="${HOME}/.poetry/bin:${PATH}"
