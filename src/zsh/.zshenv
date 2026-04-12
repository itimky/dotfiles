typeset -xr XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"${HOME}/.config"}
typeset -xr ZDOTDIR=${ZDOTDIR:-"${XDG_CONFIG_HOME}/zsh"}
typeset -xr DOTFILES=${DOTFILES:-"${${(%):-%x}:A:h:h:h}"}

for _zshrc_file (
  "${ZDOTDIR}/zshrc.d/locale.zsh"
  "${ZDOTDIR}/zshrc.d/mise.zsh"
  "${ZDOTDIR}/zshrc.d/kube.zsh"
); do
  source "${_zshrc_file}"
done
unset _zshrc_file

[[ -f "${HOME}/.env" ]] && source "${HOME}/.env"
