# ─── Environment and shell behaviour ──────────────────────────────────────────

# No fish greeting on start
set fish_greeting ""

set -gx TERM xterm-256color
set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx SECLISTS ~/SecLists

# History
set -g fish_history_max_items 10000

# Prompt / theme knobs used by the legacy theme functions
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
