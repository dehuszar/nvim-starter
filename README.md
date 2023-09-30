# Neovim Starter

Neovim configuration without third party plugins.

## Requirements

* Neovim v0.9 or greater.
* git.

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

## Keybindings

Leader key: `Space`.

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `gy` | Copy text to clipboard. |
| Normal | `gp` | Paste text from clipboard. |
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

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Ctrl-y>` | Confirm completion item. |
| Insert | `<Enter>` | Confirm completion item. |
| Insert | `<Ctrl-e>` | Cancel completion. |
| Insert | `<Ctrl-p>` | Move to previous item. |
| Insert | `<Ctrl-n>` | Move to next item. |
| Insert | `<Tab>` | Trigger completion menu. Move to next item if completion menu is visible. Otherwise, insert a tab character. |

