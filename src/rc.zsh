typeset -xr DOTFILES=${DOTFILES:-"${${(%):-%x}:A:h}/.."}

dotfiles-local-wire() {
  mkdir -p ./.devcontainer
  ln -sf "${DOTFILES}/src/devcontainer/devcontainer.json" ./.devcontainer/devcontainer.json
  ln -sf "${DOTFILES}/src/devcontainer/docker-compose.yaml" ./.devcontainer/docker-compose.yaml
  ln -sf "${DOTFILES}/src/devcontainer/Dockerfile" ./.devcontainer/Dockerfile
  ln -sf "${DOTFILES}/src/devcontainer/Makefile" ./.devcontainer/Makefile
  ln -sf "${DOTFILES}/src/devcontainer/README.md" ./.devcontainer/README.md
}

for _zshrc_file (
  $HOME/.zshrc.d/locale.zsh
  $HOME/.zshrc.d/homebrew.zsh
  $HOME/.zshrc.d/mise.zsh
  $HOME/.zshrc.d/oh-my-zsh.zsh
  $HOME/.zshrc.d/completions.zsh
  $HOME/.zshrc.d/kube.zsh
); do
  source $_zshrc_file
done
unset _zshrc_file

if [[ -f $HOME/.zshrc.d/.env ]]; then
  # Load environment variables from .env if it exists
  source $HOME/.zshrc.d/.env
fi
