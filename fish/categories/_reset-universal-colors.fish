# ─── Erase stale universal colour variables ───────────────────────────────────
#
# The old config used `set -U`, which persists into fish_variables. A universal
# variable shadows the global ones set in categories/colors.fish, so without this
# the palette would never change no matter what colors.fish says.
#
# This runs before colors.fish (underscore sorts first in the sourcing loop) and
# is a no-op once the universals are gone.

for _c in fish_color_command fish_color_param fish_color_normal \
    fish_color_autosuggestion fish_color_quote fish_color_error \
    fish_color_redirection fish_color_operator fish_color_comment \
    fish_color_end fish_color_option fish_color_escape \
    fish_pager_color_prefix fish_pager_color_completion \
    fish_pager_color_description

    if set -qU $_c
        set -eU $_c
    end
end
set -e _c
