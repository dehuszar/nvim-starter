# Neovim Starter

Neovim configuration without third party plugins.

What's included here? A custom colorscheme, statusline, tabline, lsp client config, session helper, terminal toggle, completion config, and file navigation helper.

Note: I will move this to its own repository at some point, 'cause it turns out I have use case for this config.

## Requirements

* Neovim v0.7 or greater.
* git.
* [lua-language-server](https://github.com/LuaLS/lua-language-server)
* [typescript-language-server](https://github.com/typescript-language-server/typescript-language-server)

## Installation

* Backup your existing configuration if you have one.

* If you don't know the path of the Neovim configuration folder use this command.

```sh
nvim --headless -c 'echo stdpath("config") | quit'
```

* Now clone this repository in that location.

```sh
git clone --branch xx-user-plugins https://github.com/VonHeikemen/nvim-starter /tmp/nvim-config-path
```

> Do not execute this command as is. Replace `/tmp/nvim-config-path` with the correct path from the previous step.

## Custom keybindings

Leader key: `Space`.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gy` | Copy text to clipboard. |
| Normal | `gp` | Paste text from clipboard. |
| Normal | `x` | Delete one character without modifying internal registers. |
| Normal | `X` | Delete text without modifying internal registers. |
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
| Normal | `<leader>h` | Go to first non empty character in line. |
| Normal | `<leader>l` | Go to last non empty character in line. |
| Normal | `<leader>a` | Select all text. |
| Normal | `<leader>w` | Save file. |
| Normal | `<leader>bq` | Close current buffer. |
| Normal | `<leader>bl` | Go to last active buffer. |
| Normal | `<leader><space>` | Search open buffers. |
| Normal | `<leader>e` | Toggle file explorer. |
| Normal | `<leader>E` | Open file explorer in current folder. |
| Normal | `<F5>` | Toggle embedded terminal. |
| Normal | `<leader>m` | Include current buffer in menu. |
| Normal | `<leader>M` | Include current buffer in menu and show the menu. |
| Insert | `<C-d>` | Expand abbreviations. This is the hack I use for snippets. |
| Normal | `M` | Show buffer menu. |
| Normal | `<Alt-1>` | Navigate to the file in the first line of the buffer menu. |
| Normal | `<Alt-2>` | Navigate to the file in the second line of the buffer menu. |
| Normal | `<Alt-3>` | Navigate to the file in the third line of the buffer menu. |
| Normal | `<Alt-4>` | Navigate to the file in the fourth line of the buffer menu. |

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Ctrl-y>` | Confirm completion item. |
| Insert | `<Enter>` | Confirm completion item. |
| Insert | `<Ctrl-e>` | Toggle completion menu. |
| Insert | `<Ctrl-p>` | Move to previous item. |
| Insert | `<Ctrl-n>` | Move to next item. |
| Insert | `<Tab>` | Show completion menu if cursor is in the middle of a word. Go to next completion item if completion menu is visible. Otherwise, insert tab character. |
| Insert | `<Shift-Tab>` | If completion menu is visible, go to previous completion item. Otherwise, insert tab character. |

## How to install third-party plugins?

Turns out we only need to download them in a specific folder and Neovim will take care of the rest. We can list all the available directories using this command.

```vim
:lua vim.tbl_map(print, vim.opt.packpath:get())
```

In one of those directories we have to create a folder called `pack` and inside pack we must create a "package". A package is a folder that contains several plugins. It must have this structure.

```
package-folder
├── opt
│   ├── [plugin 1]
│   └── [plugin 2]
└── start
    ├── [plugin 3]
    └── [plugin 4]
```

Plugins in the `opt` folder will only be loaded if we execute the command `packadd`. The plugins in `start` will be loaded automatically during Neovim's startup process.

So let's assume we have this path in our `packpath`.

```
/home/dev/.local/share/nvim/site
```

To install plugins there create a `pack` folder. Then create a folder with any name you want. Let's name the package `github` because why not? So the full path for our plugins will be this.

```
/home/dev/.local/share/nvim/site/pack/github
```

So to install a plugin like [tokyonight](https://github.com/folke/tokyonight.nvim) and have it load automatically, we should place it here.

```
/home/dev/.local/share/nvim/site/pack/github/start/tokyonight.nvim
```

That's it. Well... you need to use the plugin but that's another story.

To know more about packages in Neovim read the help page.

```vim
:help packages
```

