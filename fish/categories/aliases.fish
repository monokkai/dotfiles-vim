# ─── Aliases ──────────────────────────────────────────────────────────────────

# eza (modern ls replacement)
alias ll "eza -al --icons --git --group-directories-first --time-style=long-iso --color=always --no-permissions --no-user --header --color-scale"
alias ls "eza --icons --color=always"
alias l "eza -l --icons --git --color=always"
alias la "eza -a --icons --color=always"

# Editor
command -qv nvim && alias vim nvim
alias n nvim

# Git
alias g git
alias gs "git status -sb"
alias gl "git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(blue)%d%Creset %s %Cgreen(%cr) %C(bold cyan)<%an>%Creset' --abbrev-commit"
alias gd "git diff --color-words"
alias gp "git push -u origin"
alias ga "git add ."
alias gi "git init"
alias gcz "git cz -a"
alias lg lazygit

# tmux
alias tn "tmux new"

# Infra
alias kb kubectl
alias tf terraform
alias bsj "brew services start jenkins-lts"
alias bss "brew services stop jenkins-lts"

# Misc
alias c clear
alias br browsh
alias m monokkai
