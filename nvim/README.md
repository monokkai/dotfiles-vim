# diegomaajer — Neovim Config

Personal Neovim configuration built on [LazyVim](https://lazyvim.org) with custom keymaps, plugins, and language support.

---

## Theme

**Sonokai** (`andromeda` style) with transparent background.

---

## Language Support

| Language   | LSP | Formatter              | Debugger |
|------------|-----|------------------------|----------|
| TypeScript | ✓   | Prettier               | —        |
| JavaScript | ✓   | Prettier               | —        |
| Rust       | ✓   | rustfmt                | —        |
| Go         | ✓   | goimports + gofumpt    | Delve    |
| Java       | ✓   | google-java-format     | —        |
| CSS        | ✓   | Prettier               | —        |
| Tailwind   | ✓   | —                      | —        |
| HTML       | ✓   | —                      | —        |
| Lua        | ✓   | stylua                 | —        |
| YAML       | ✓   | —                      | —        |

---

## Keymaps

> `<Leader>` = `Space`

### File Explorer

| Key           | Action                          |
|---------------|---------------------------------|
| `Space + T`   | Toggle Neo-tree file explorer   |
| `sf`          | Open Telescope file browser at current buffer dir |

### Git

| Key   | Action                          |
|-------|---------------------------------|
| `lg`  | Open Lazygit floating window    |
| `Space + gb` | Git blame current line   |
| `Space + go` | Open file in git remote  |

### Tabs

| Key       | Action           |
|-----------|------------------|
| `Tab`     | Next tab         |
| `S-Tab`   | Previous tab     |
| `te`      | New tab (tabedit)|

### Window Splitting

| Key   | Action           |
|-------|------------------|
| `ss`  | Horizontal split |
| `sv`  | Vertical split   |

### Window Navigation

| Key   | Action              |
|-------|---------------------|
| `sh`  | Move to left window |
| `sk`  | Move to upper window|
| `sj`  | Move to lower window|
| `sl`  | Move to right window|

### Window Resizing

| Key              | Action          |
|------------------|-----------------|
| `Ctrl + W + ←`   | Shrink width    |
| `Ctrl + W + →`   | Expand width    |
| `Ctrl + W + ↑`   | Increase height |
| `Ctrl + W + ↓`   | Decrease height |

### Telescope (Search)

| Key           | Action                                      |
|---------------|---------------------------------------------|
| `;f`          | Find files (respects .gitignore)            |
| `;r`          | Live grep (search text in project)          |
| `\\`          | List open buffers                           |
| `;t`          | Search help tags                            |
| `;;`          | Resume last Telescope picker                |
| `;e`          | Show diagnostics                            |
| `;s`          | List functions/variables (Treesitter)       |
| `;c`          | LSP incoming calls for word under cursor    |
| `Space + fP`  | Find plugin files                           |

### LSP

| Key           | Action                        |
|---------------|-------------------------------|
| `gd`          | Go to definition (Telescope)  |
| `Ctrl + J`    | Go to next diagnostic         |
| `Space + i`   | Toggle inlay hints            |
| `Space + r`   | Replace hex color with HSL    |

### Editing

| Key           | Action                                      |
|---------------|---------------------------------------------|
| `;q`          | Toggle comment on current line              |
| `;q` (visual) | Toggle comment on selected lines            |
| `x`           | Delete char (no register)                   |
| `dw`          | Delete word backwards (no register)         |
| `Ctrl + A`    | Select all                                  |
| `+`           | Increment number                            |
| `-`           | Decrement number                            |
| `Space + p`   | Paste from yank register (no overwrite)     |
| `Space + c`   | Change without affecting registers          |
| `Space + d`   | Delete without affecting registers          |
| `Space + o`   | New line below (no continuation)            |
| `Space + O`   | New line above (no continuation)            |
| `Ctrl + M`    | Jump forward in jumplist                    |

### Buffers

| Key           | Action                   |
|---------------|--------------------------|
| `Space + th`  | Close hidden buffers     |
| `Space + tu`  | Close nameless buffers   |

### Other

| Key           | Action                   |
|---------------|--------------------------|
| `Space + z`   | Toggle Zen Mode          |

---

## Plugins

| Plugin | Purpose |
|--------|---------|
| [LazyVim](https://lazyvim.org) | Base config framework |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim) | File browser extension |
| [sonokai](https://github.com/sainnhe/sonokai) | Colorscheme |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab bar (yellow active tab) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI for messages/cmdline |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletion |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Lazygit + utilities |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | Distraction-free editing |
| [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | Inline color preview |
| [incline.nvim](https://github.com/b0o/incline.nvim) | Floating filename display |
| [dial.nvim](https://github.com/monaqa/dial.nvim) | Enhanced increment/decrement |
| [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) | Incremental LSP rename |
| [mini.bracketed](https://github.com/echasnovski/mini.bracketed) | Navigate with `[` `]` |
| [close-buffers.nvim](https://github.com/kazhala/close-buffers.nvim) | Smart buffer closing |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatter (Rust, Go, Java) |

---

## File Structure

```
nvim/
├── lua/
│   ├── config/
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── keymaps.lua      # All keybindings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── options.lua      # Neovim options
│   ├── plugins/
│   │   ├── coding.lua       # Coding plugins
│   │   ├── colorscheme.lua  # Theme config
│   │   ├── editor.lua       # Editor plugins (telescope, neo-tree)
│   │   ├── formatting.lua   # Formatters (rustfmt, gofumpt, google-java-format)
│   │   ├── lsp.lua          # LSP configuration
│   │   ├── treesitter.lua   # Syntax highlighting
│   │   └── ui.lua           # UI plugins (bufferline, lualine, noice)
│   ├── diegomaajer/
│   │   ├── discipline.lua   # Custom utilities
│   │   ├── hsl.lua          # HSL color utilities
│   │   └── lsp.lua          # LSP utilities
│   └── util/
│       └── debug.lua        # Debug utilities
└── queries/
    └── vim/
        └── highlights.scm   # Treesitter query fix
```
