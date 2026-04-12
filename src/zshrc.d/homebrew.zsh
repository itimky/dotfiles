typeset -xr HOMEBREW_NO_ANALYTICS=1
typeset -xr HOMEBREW_NO_AUTO_UPDATE=1

if [[ $OSTYPE == linux* ]] || ! command -v brew >/dev/null 2>&1; then
	return
fi

local -r HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-$(brew --prefix)}
for _gnu_pkg (coreutils gnu-sed grep gnu-tar gawk findutils make); do
	path=($HOMEBREW_PREFIX/opt/$_gnu_pkg/libexec/gnubin $path)
	manpath=($HOMEBREW_PREFIX/opt/$_gnu_pkg/libexec/gnuman $manpath)
done
unset _gnu_pkg
