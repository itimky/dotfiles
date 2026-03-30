for _zshrc_file (
  $HOME/.zshrc.d/locale.zsh
  $HOME/.zshrc.d/homebrew.zsh
  $HOME/.zshrc.d/gnu.zsh
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

