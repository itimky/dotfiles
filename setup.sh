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
