# Homebrew
typeset -gx HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}
path=($HOMEBREW_PREFIX/bin $path)
