source "${HOME}/.zshrc.d/locale.zsh"
source "${HOME}/.zshrc.d/oh-my-zsh.zsh"
source "${HOME}/.zshrc.d/homebrew.zsh"
source "${HOME}/.zshrc.d/go.zsh"
source "${HOME}/.zshrc.d/python.zsh"
source "${HOME}/.zshrc.d/completions.zsh"
source "${HOME}/.zshrc.d/kube.zsh"
source "${HOME}/.zshrc.d/gnu.zsh"
source "${HOME}/.zshrc.d/asdf.zsh"
source "${HOME}/.zshrc.d/pnpm.zsh"

if [ -f "${HOME}/.zshrc.d/.env" ]; then
  # Load environment variables from .env if it exists
  source "${HOME}/.zshrc.d/.env"
fi
