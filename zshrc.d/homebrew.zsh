# Homebrew
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"
export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
