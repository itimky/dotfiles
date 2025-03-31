# brew install coreutils gnu-sed grep gnu-tar gawk findutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix grep)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix gnu-tar)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix gawk)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"

export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix grep)/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix gnu-tar)/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix gawk)/libexec/gnuman:$MANPATH"
export MANPATH="$(brew --prefix findutils)/libexec/gnuman:$MANPATH"
