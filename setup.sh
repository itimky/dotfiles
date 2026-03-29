#!/usr/bin/env sh

# path to setup.sh folder
DIR=$(cd $(dirname $0) > /dev/null && pwd)

# zsh
ln -sf "${DIR}/zshrc" "${HOME}/.zshrc"
ln -sfn "${DIR}/zshrc.d" "${HOME}/.zshrc.d"

# vim
ln -sf "${DIR}/vim/vimrc" "${HOME}/.vimrc"
ln -sfn "${DIR}/vim" "${HOME}/.vim"

# git
ln -sf "${DIR}/gitconfig" "${HOME}/.gitconfig"
ln -sf "${DIR}/gitignore" "${HOME}/.gitignore"

# tmux
ln -sf "${DIR}/tmux.conf" "${HOME}/.tmux.conf"

# vscode
VSCODE_USER_DIR=""
if [ "$(uname -s)" = "Darwin" ]; then
	VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"
elif [ -n "${XDG_CONFIG_HOME}" ]; then
	VSCODE_USER_DIR="${XDG_CONFIG_HOME}/Code/User"
else
	VSCODE_USER_DIR="${HOME}/.config/Code/User"
fi
mkdir -p "${VSCODE_USER_DIR}"
ln -sf "${DIR}/vscode/settings.json" "${VSCODE_USER_DIR}/settings.json"

