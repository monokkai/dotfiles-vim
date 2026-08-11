# ─── Tide prompt tuning ───────────────────────────────────────────────────────
#
# How Tide v5 shortens the path (see functions/_tide_pwd.fish):
#
#   * It truncates ADAPTIVELY, not to a fixed width. Nothing is shortened while
#     the prompt still fits; once the path is longer than the space between the
#     left and right prompts, it shortens middle directories one at a time,
#     each to the shortest prefix that is still unambiguous on disk.
#   * The first segment (~) and the CURRENT directory are never truncated.
#   * Any directory containing a "marker" file is kept in full and highlighted
#     as an anchor -- this is what keeps project roots readable.
#
# So there is no tide_pwd_dir_length / tide_pwd_max_dirs; those do not exist.
# The lever that actually controls how much stays readable is the marker list.

# Keep project roots un-truncated. Anything holding one of these is shown in
# full, so ~/Developments/inkdrop/desktop-v6/src/browser/components collapses the
# noisy middle but keeps the directory that owns package.json / .git legible.
set -U tide_pwd_markers \
    .git .hg .svn .bzr .citc .cvs \
    package.json Cargo.toml composer.json go.mod pyproject.toml \
    .node-version .python-version .ruby-version .terraform \
    .shorten_folder_marker

# Give the path more room before truncation kicks in by keeping the right-hand
# prompt lean -- the fewer items on the right, the longer the path may run.
# (Right prompt items are managed by `tide configure`; see MEMORY for the list.)
