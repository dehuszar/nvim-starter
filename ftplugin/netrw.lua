if vim.g.user_netrw_config == nil then
  -- Sync current directory with browsing directory
  vim.g.netrw_keepdir = 0

  -- Hide banner
  vim.g.netrw_banner = 0

  -- Hide dotfiles
  vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

  -- A better copy command (for unix-like systems)
  vim.g.netrw_localcopydircmd = 'cp -r'

  vim.g.user_netrw_config = 1
end

if vim.o.columns < 90 then
  -- If the screen is small, occupy half
  vim.g.netrw_winsize = 50
else
  -- else take 30%
  vim.g.netrw_winsize = 30
end

local bufnr = vim.api.nvim_get_current_buf()

local function map(mode, lhs, desc, opts)
  local opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(modes, lhs, rhs, opts)
end

-- Close netrw window
map('n', 'q', ':Lexplore<CR>', {nowait = true})

-- Go to file and close Netrw window
map('n', 'L', '<CR>:Lexplore<CR>')

-- Go back in history
map('n', 'H', 'u')

-- Go up a directory
map('n', 'h', '-^')

-- Go down a directory / open file
map('n', 'l', '<CR>')

-- Toggle dotfiles
map('n', 'za', 'gh')

-- Toggle the mark on a file
map('n', '<TAB>', 'mf')

-- Unmark all files in the buffer
map('n', '<S-TAB>', 'mF')

-- Unmark all files
map('n', '<Leader><TAB>', 'mu')

-- 'Bookmark' a directory
map('n', 'bb', 'mb')

-- Delete the most recent directory bookmark
map('n', 'bd', 'mB')

-- Got to a directory on the most recent bookmark
map('n', 'bl', 'gb')

-- Create a file
map('n', 'ff', '%')

-- Rename a file
map('n', 'fe', 'R')

-- Copy marked files
map('n', 'fc', 'mc')

-- Move marked files
map('n', 'fx', 'mm')

-- Execute a command on marked files
map('n', 'f;', 'mx')

-- Show the list of marked files
map('n', 'fl', ':echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>')

-- Show the current target directory
map('n', 'fq', [[:echo 'Target:' . netrw#Expose("netrwmftgt")<CR>]])

-- Set the directory under the cursor as the current target
map('n', 'fg', 'mtfq')

-- Close the preview window
map('n', 'P', '<C-w>z')

