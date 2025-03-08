complete -o nospace -C /opt/homebrew/bin/terraform terraform
command -v flux >/dev/null && . <(flux completion zsh)
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
