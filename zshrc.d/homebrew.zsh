typeset -gx HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-$(
	command -v brew >/dev/null && brew --prefix 2>/dev/null ||
	/opt/homebrew/bin/brew --prefix 2>/dev/null ||
	/usr/local/bin/brew --prefix 2>/dev/null
)}

[[ -n ${HOMEBREW_PREFIX:-} ]] && path=($HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $path)
