# brew install coreutils gnu-sed grep gnu-tar gawk findutils
for _gnu_pkg in coreutils gnu-sed grep gnu-tar gawk findutils; do
	export PATH="/opt/homebrew/opt/${_gnu_pkg}/libexec/gnubin:${PATH}"
	export MANPATH="/opt/homebrew/opt/${_gnu_pkg}/libexec/gnuman:${MANPATH}"
done
unset _gnu_pkg
