# ─── Syntax highlighting (craftzdog / solarized-osaka style) ──────────────────
#
# NOTE: these are `set -g`, not `set -U`. Universal variables are written once
# into fish_variables and then this file is ignored on every later start, which
# makes edits here look like they do nothing. Global scope is re-read each time.
#
# Any stale universal copies are erased in categories/_reset-universal-colors.fish

# Commands: yarn, npm, brew, git
set -g fish_color_command 268BD3 --bold
# Quoted strings
set -g fish_color_quote 29A298
# Arguments / params: dev, add, -D
set -g fish_color_param 9EABAC
# Options and flags
set -g fish_color_option 839496
# Redirections: > >> 2>&1
set -g fish_color_redirection B28500
# Pipes, ; and &
set -g fish_color_end 849900
# Errors / unknown commands
set -g fish_color_error DB302D
# Comments
set -g fish_color_comment 576D74 --italics
# Default text
set -g fish_color_normal 9EABAC
# Ghost text of the autosuggestion
set -g fish_color_autosuggestion 3E5560
# Operators: * ** ~
set -g fish_color_operator 29A298
# $variables
set -g fish_color_escape D33682
# Valid file path under the cursor
set -g fish_color_valid_path --underline
# The > in the prompt when a command is not found
set -g fish_color_search_match --background=063540

# ─── Completion pager ─────────────────────────────────────────────────────────
set -g fish_pager_color_prefix 268BD3 --bold
set -g fish_pager_color_completion 9EABAC
set -g fish_pager_color_description 576D74
set -g fish_pager_color_selected_background --background=063540
