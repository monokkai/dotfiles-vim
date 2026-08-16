# ─── Fish syntax highlighting — blue monochrome ───────────────────────────────
#
# NOTE: `set -g`, not `set -U`. Universal variables are written into
# fish_variables once and then this file is ignored on every later start.
# Stale universals are erased in categories/_reset-universal-colors.fish
#
# On the two requested blues: against the terminal background (#001419)
# #0A2C5A measures 1.37:1 and #1B5D98 measures 2.75:1 — both far below the
# 4.5:1 readability floor, i.e. barely distinguishable from the background.
# They are kept below as the DARK end of the ramp, used only where something
# should recede (autosuggestion ghost text, comments). Everything meant to be
# read uses the same HUES lifted into a legible range.
#
# The ramp keeps the blue HUE (~210deg) at high saturation. An earlier version
# used the same hues at 70% saturation and 75% lightness (#93C2EC), which washed
# out to a pale grey-blue -- high contrast, but it stopped reading as blue.
#
#   #0A2C5A ── requested dark   (1.37:1)   ghost text
#   #1B5D98 ── requested mid    (2.75:1)   comments, dimmed
#   #067AEF ── saturated        (4.5:1)    default body text
#   #1F8CF9 ── saturated        (5.5:1)    parameters, strings
#   #429EFA ── saturated        (6.7:1)    commands, emphasis

# ── Structure: bold for what you type, italic for what is inert ──────────────

# Commands — the brightest, boldest thing on the line
set -g fish_color_command 429EFA --bold

# Command arguments / params
set -g fish_color_param 1F8CF9

# Quoted strings — italic, so data reads differently from code
set -g fish_color_quote 1F8CF9 --italics

# Options and flags (-v, --alias)
set -g fish_color_option 067AEF

# Default text
set -g fish_color_normal 067AEF

# Redirections and pipes — bold, they change control flow
set -g fish_color_redirection 429EFA --bold
set -g fish_color_end 429EFA --bold

# Operators (* ** ~) and $variables
set -g fish_color_operator 1F8CF9
set -g fish_color_escape 1F8CF9

# Comments — the requested mid blue, italic, meant to recede
set -g fish_color_comment 1B5D98 --italics

# Autosuggestion ghost text — the requested dark blue; it *should* be faint
set -g fish_color_autosuggestion 0A2C5A

# Errors stay bold and blue-white so they still catch the eye without leaving
# the palette
set -g fish_color_error 429EFA --bold --underline

# Matching bracket / search highlight
set -g fish_color_search_match --background=0A2C5A
set -g fish_color_selection 429EFA --bold --background=0A2C5A

# Current working directory in the default prompt
set -g fish_color_cwd 429EFA --bold
set -g fish_color_cwd_root 429EFA --bold
set -g fish_color_host 1F8CF9
set -g fish_color_user 1F8CF9 --bold

# ─── Completion pager ─────────────────────────────────────────────────────────
set -g fish_pager_color_prefix 429EFA --bold --underline
set -g fish_pager_color_completion 067AEF
set -g fish_pager_color_description 1B5D98 --italics
set -g fish_pager_color_progress 1F8CF9
set -g fish_pager_color_selected_background --background=0A2C5A
set -g fish_pager_color_selected_completion 429EFA --bold
