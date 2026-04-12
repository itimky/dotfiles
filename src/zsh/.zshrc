dotfiles-local-wire() {
  mkdir -p ./.devcontainer
  ln -sf "${DOTFILES}/src/devcontainer/devcontainer.json" ./.devcontainer/devcontainer.json
  ln -sf "${DOTFILES}/src/devcontainer/docker-compose.yaml" ./.devcontainer/docker-compose.yaml
  ln -sf "${DOTFILES}/src/devcontainer/Dockerfile" ./.devcontainer/Dockerfile
  ln -sf "${DOTFILES}/src/devcontainer/Makefile" ./.devcontainer/Makefile
  ln -sf "${DOTFILES}/src/devcontainer/README.md" ./.devcontainer/README.md
}

for _zshrc_file (
  "${ZDOTDIR}/zshrc.d/homebrew.zsh"
  "${ZDOTDIR}/zshrc.d/mise.zsh"
  "${ZDOTDIR}/zshrc.d/oh-my-zsh.zsh"
  "${ZDOTDIR}/zshrc.d/completions.zsh"
); do
  source "${_zshrc_file}"
done
unset _zshrc_file
