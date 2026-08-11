# ══════════════════════════════════════════════════════════════════════════════
#  fish config — split into categories/ for navigation
#
#    categories/env.fish      shell behaviour, TERM, EDITOR, history
#    categories/paths.fish    PATH and language toolchains
#    categories/aliases.fish  aliases
#    categories/colors.fish   syntax highlighting palette
#
#  conf.d/ is left alone: it belongs to fisher plugins (tide, nvm, sdkman).
#  Previous single-file config is kept at config.fish.bak
# ══════════════════════════════════════════════════════════════════════════════

set -l __fish_conf_dir (dirname (status --current-filename))

for __file in $__fish_conf_dir/categories/*.fish
    source $__file
end
set -e __file

# ─── OS-specific ──────────────────────────────────────────────────────────────
switch (uname)
    case Darwin
        source $__fish_conf_dir/config-osx.fish
    case Linux
        source $__fish_conf_dir/config-linux.fish
    case '*'
        source $__fish_conf_dir/config-windows.fish
end

# ─── Machine-local overrides, not tracked in git ──────────────────────────────
if test -f $__fish_conf_dir/config-local.fish
    source $__fish_conf_dir/config-local.fish
end

# ─── Tools that inject their own shell glue ───────────────────────────────────
type -q thefuck && thefuck --alias | source
