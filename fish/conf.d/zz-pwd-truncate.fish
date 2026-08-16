# Overrides Tide's _tide_pwd (functions/_tide_pwd.fish) with a version that
# truncates unconditionally. Lives in conf.d/ -- which fish sources AFTER
# autoloading functions/ -- so the plugin's own file is left untouched and
# `fisher update` cannot clobber this. The zz- prefix keeps it last.
#
# Replacement for Tide's _tide_pwd.
#
# Tide's stock version only shortens a directory once the prompt runs out of
# room, so on a wide terminal a deep path is always shown in full:
#
#   ~/Desktop/developement/full-stack-projects/maajer-store
#
# This version truncates unconditionally: every parent directory is cut to
# $tide_pwd_dir_length characters (default 3), while ~ and the current directory
# are always left intact:
#
#   ~/Des/dev/ful/maajer-store
#
# Directories holding one of $tide_pwd_markers (.git, package.json, ...) are kept
# in full and coloured as anchors, so project roots stay readable.
#
# fish_prompt reads $_tide_pwd_len to size the connector line, so this must set
# that global exactly as the original did.

function _tide_pwd
    set -l dir_len $tide_pwd_dir_length
    test -z "$dir_len" && set dir_len 3

    set -l color_anchors (set_color -o $tide_pwd_color_anchors)
    set -l color_truncated (set_color $tide_pwd_color_truncated_dirs)
    set -l reset (set_color normal -b $tide_pwd_bg_color; set_color $tide_pwd_color_dirs)

    set -l split_pwd (string replace -r "^$HOME" '~' -- $PWD | string split /)

    # Plain (uncoloured) copy, used to measure the real display width.
    set -l plain $split_pwd

    if test (count $split_pwd) -gt 2
        for i in (seq 2 (math (count $split_pwd) - 1))
            set -l seg $split_pwd[$i]
            test -z "$seg" && continue

            # Keep project roots whole.
            set -l parent (string join / $split_pwd[..$i] | string replace '~' $HOME)
            if path is $parent/$tide_pwd_markers 2>/dev/null
                set split_pwd[$i] "$color_anchors$seg$reset"
                continue
            end

            if test (string length -- $seg) -gt $dir_len
                # Preserve a leading dot: .config -> .co, not ".c"
                set -l trunc
                if string match -qr '^\.' -- $seg
                    set trunc (string sub -l (math $dir_len + 1) -- $seg)
                else
                    set trunc (string sub -l $dir_len -- $seg)
                end
                set split_pwd[$i] "$color_truncated$trunc$reset"
                set plain[$i] $trunc
            end
        end
    end

    # Current directory is always shown in full, highlighted.
    set -l last (count $split_pwd)
    if test $last -gt 1
        set split_pwd[$last] "$color_anchors$plain[$last]$reset"
    else
        set split_pwd[1] "$color_anchors$plain[1]$reset"
    end

    set -l icon
    if test "$plain[1]" = '~'
        test -n "$tide_pwd_icon_home" && set icon "$tide_pwd_icon_home "
    else if not test -w .
        test -n "$tide_pwd_icon_unwritable" && set icon "$tide_pwd_icon_unwritable "
    else
        test -n "$tide_pwd_icon" && set icon "$tide_pwd_icon "
    end

    # fish_prompt sizes the connector from this.
    string join / -- "$icon$plain[1]" $plain[2..] | string length -V | read -g _tide_pwd_len

    string join / -- "$reset$icon$split_pwd[1]" $split_pwd[2..]
end
