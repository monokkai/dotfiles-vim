# ─── PATH and language toolchains ─────────────────────────────────────────────

# Homebrew
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

# Project-local and user binaries
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Carried over from the old zsh config
set -gx PATH $HOME/.yarn/bin $HOME/.npm-global/bin $HOME/.console-ninja/.bin $HOME/.spicetify $PATH
