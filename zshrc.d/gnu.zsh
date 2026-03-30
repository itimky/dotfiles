# brew install coreutils gnu-sed grep gnu-tar gawk findutils
for _gnu_pkg (coreutils gnu-sed grep gnu-tar gawk findutils); do
	path=($HOMEBREW_PREFIX/opt/$_gnu_pkg/libexec/gnubin $path)
	manpath=($HOMEBREW_PREFIX/opt/$_gnu_pkg/libexec/gnuman $manpath)
done
unset _gnu_pkg
