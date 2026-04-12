dotfiles-local-wire() {
  mkdir -p ./.devcontainer
  ln -sf "${DOTFILES}/devcontainer/devcontainer.json" ./.devcontainer/devcontainer.json
  ln -sf "${DOTFILES}/devcontainer/docker-compose.yaml" ./.devcontainer/docker-compose.yaml
  ln -sf "${DOTFILES}/devcontainer/Dockerfile" ./.devcontainer/Dockerfile
  ln -sf "${DOTFILES}/devcontainer/Makefile" ./.devcontainer/Makefile
  ln -sf "${DOTFILES}/devcontainer/README.md" ./.devcontainer/README.md
}

for _zshrc_file (
  "${DOTFILES}/homebrew/homebrew.zsh"
  "${ZDOTDIR}/mise.zsh"
  "${ZDOTDIR}/oh-my-zsh.zsh"
  "${ZDOTDIR}/completions.zsh"
); do
  source "${_zshrc_file}"
done
unset _zshrc_file
