export ASDF_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"

typeset -gaU path
typeset -gaU fpath

# Keep asdf shims first in PATH for tool version correctness.
path=("${ASDF_DIR}/shims" ${path:#"${ASDF_DIR}/shims"})

# Ensure asdf completions are present exactly once.
fpath=("${ASDF_DIR}/completions" ${fpath:#"${ASDF_DIR}/completions"})
