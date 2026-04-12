typeset -xr XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"${HOME}/.config"}
typeset -xr ZDOTDIR=${ZDOTDIR:-"${XDG_CONFIG_HOME}/zsh"}
typeset -xr DOTFILES=${DOTFILES:-"${${(%):-%x}:A:h:h:h}"}

for _zshrc_file (
  "${ZDOTDIR}/locale.zsh"
  "${ZDOTDIR}/mise.zsh"
  "${ZDOTDIR}/kube.zsh"
); do
  source "${_zshrc_file}"
done
unset _zshrc_file

[[ -f "${HOME}/.env" ]] && source "${HOME}/.env"
