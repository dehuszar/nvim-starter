# Neovim Starter

Lightweight configuration focused on providing "basic needs" with little boilerplace. It includes better syntax highlight with `treesitter`, `telescope` as a fuzzy finder and a ready made LSP setup with autocompletion.

## Requirements

* Neovim v0.8 or greater.
* git.
* A `C` compiler. Can be `gcc`, `tcc` or `zig`.
* [make](https://www.gnu.org/software/make/), the build tool.
* (optional) [ripgrep](https://github.com/BurntSushi/ripgrep). Improves project wide search speed.
* (optional) [fd](https://github.com/sharkdp/fd). Improves file search speed.

## Installation

* Backup your existing configuration if you have one.

* Create an `init.lua` file in your system. Use this command if you don't know the specific location of Neovim's configuration folder.

```sh
nvim --headless -c 'call mkdir(stdpath("config"), "p") | exe "edit" stdpath("config") . "/init.lua" | write | quit'
```

* Open your configuration file with Neovim.

```sh
nvim -c 'edit $MYVIMRC'
```

* Copy the content of `init.lua` in this repository into your own `init.lua`.

* Next time you start Neovim all plugins will be downloaded automatically. After plugins are downloaded restart Neovim.

### Plugins directory

Your plugins will be installed in a separate directory from your configuration. The location of this directory depends on your operating system and environment variables, so you'll need to execute this command to know where that is.

```sh
nvim --headless -c 'echo stdpath("data") . "/lazy/lazy.nvim" | quit'
```

## About LSP servers

They are external programs that provide IDE-like features to Neovim. You need to install them manually. Go to nvim-lspconfig's documenation, in [server_configuration.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) you'll find links and instruction on how to install all the supported LSP servers.

Once the LSP server is available in your system you need to add the setup function to add the end of your config.

For example, if you installed the typescript language server you need to add this.

```lua
require('lspconfig').tsserver.setup({})
```

## Keybindings

Leader key: `Space`.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `K` | Displays hover information about the symbol under the cursor. |
| Normal | `gd` | Jump to the definition. |
| Normal | `gD` | Jump to declaration. |
| Normal | `gi` | Lists all the implementations for the symbol under the cursor. |
| Normal | `go` | Jumps to the definition of the type symbol |
| Normal | `gr` | Lists all the references. |
| Normal | `gs` | Displays a function's signature information. |
| Normal | `<F2>` | Renames all references to the symbol under the cursor. |
| Normal | `<F3>` | Format code in current buffer. |
| Normal | `<F4>` | Selects a code action available at the current cursor position. |
| Normal | `gl` | Show diagnostics in a floating window. |
| Normal | `[d` | Move to the previous diagnostic. |
| Normal | `]d` | Move to the next diagnostic. |
| Normal | `<leader>?` | Search oldfiles history. |
| Normal | `<leader><space>` | Search open buffers. |
| Normal | `<leader>ff` | Find file in current working directory. |
| Normal | `<leader>fg` | Search pattern in current working directory. Interactive "grep search". |
| Normal | `<leader>fd` | Search diagnostics in current file. |
| Normal | `<leader>fs` | Search pattern in current file. |

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Ctrl-y>` | Confirm completion. |
| Insert | `<Enter>` | Confirm completion. |
| Insert | `<Ctrl-e>` | Cancel completion. |
| Insert | `<Ctrl-p>` | Move to previous item. |
| Insert | `<Ctrl-n>` | Move to next item. |
| Insert | `<Ctrl-u>` | Scroll up in documentation window. |
| Insert | `<Ctrl-d>` | Scroll down in documentation window. |
| Insert | `<Ctrl-b>` | Jump to the previous snippet placeholder. |
| Insert | `<Ctrl-f>` | Jump to the next snippet placeholder. |
| Insert | `<Ctrl-Space>` | Trigger completion. |

## Plugin list

| Name | Description  |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager. |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Collection of colorscheme for Neovim. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Pretty statusline. |
| [mini.comment](https://github.com/echasnovski/mini.comment) | Toggle comments. |
| [mini.surround](https://github.com/echasnovski/mini.surround) | Add, replace, delete surroundings (like pair of parenthesis, quotes, etc).  |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Collection of lua modules. It helps plugin authors solve common problems. |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder. |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Extension for telescope. Allows fzf-like syntax in search queries. |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Configures treesitter parsers. Provides modules to manipulate code. |
| [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) | Bundles the boilerplate code needed to configure lspconfig and nvim-cmp. |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim's LSP client.  |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine. |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source. Show suggestions based on LSP servers queries. |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine. |

