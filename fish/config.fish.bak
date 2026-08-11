# Отключаем приветствие
set fish_greeting ""

# Терминал
set -gx TERM xterm-256color

# --- Fish syntax highlighting colors (craftzdog‑style) ---
# Commands like yarn, npm, brew
set -U fish_color_command 285498
# Arguments/params like astro, dev, etc (underlined)
set -U fish_color_param --underline 2A9AD3
# Default text color for Fish's own output
set -U fish_color_normal 2A90DB

# Autosuggestions (keep as blue, tweak if you want)
set -U fish_color_autosuggestion blue

# --- Тема fish (если нужна) ---
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# --- Пути ---
# Homebrew
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Пути из zsh-конфига
set -gx PATH $HOME/.yarn/bin $HOME/.npm-global/bin $HOME/.console-ninja/.bin $HOME/.spicetify $PATH

# --- Алиасы ---
# eza (modern ls replacement)
alias ll "eza -al --icons --git --group-directories-first --time-style=long-iso --color=always --no-permissions --no-user --header --color-scale"
alias ls "eza --icons --color=always"
alias l "eza -l --icons --git --color=always"
alias la "eza -a --icons --color=always"

# Other aliases
alias g git
command -qv nvim && alias vim nvim
alias n nvim
alias tn "tmux new"
alias c clear
alias kb kubectl
alias tf terraform
alias bsj "brew services start jenkins-lts"
alias bss "brew services stop jenkins-lts"

alias gs "git status -sb"
alias gl "git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(blue)%d%Creset %s %Cgreen(%cr) %C(bold cyan)<%an>%Creset' --abbrev-commit"
alias gd "git diff --color-words"
alias gp "git push -u origin"
alias ga "git add ."
alias g git
alias gi "git init"
alias br browsh
alias lg lazygit
alias gcz "git cz -a"

alias m monokkai

# --- Переменные окружения ---
set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx SECLISTS ~/SecLists

# --- История ---
set -U fish_history_max_items 10000

# --- ОС-зависимые настройки ---
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

# --- Локальные настройки, если есть ---
set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

thefuck --alias | source
