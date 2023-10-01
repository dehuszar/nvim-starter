-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.cursorline = true
vim.opt.scrolloff = 2
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.path = {'.', '', '**'}
vim.opt.wildignore = {'**/node_modules/**', '**/vendor/**'}

-- Augroup for user created autocommands
vim.api.nvim_create_augroup('user_cmds', {clear = true})


-- ========================================================================== --
-- ==                               KEYMAPS                                == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = ' '

-- Basic clipboard interaction
vim.keymap.set({'n', 'x', 'o'}, 'gy', '"+y') -- copy
vim.keymap.set({'n', 'x', 'o'}, 'gp', '"+p') -- paste

-- Go to first character in line
vim.keymap.set('', '<Leader>h', '^')

-- Go to last character in line
vim.keymap.set('', '<Leader>l', 'g_')

-- Whatever you delete, make it go away
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set({'n', 'x'}, 'X', '"_d')

-- Select all text
vim.keymap.set('n', '<leader>a', '<cmd>keepjumps normal! ggVG<cr>')

-- Write file
vim.keymap.set('n', '<Leader>w', '<cmd>write<cr>')

-- Safe quit
vim.keymap.set('n', '<Leader>qq', '<cmd>quitall<cr>')

-- Force quit
vim.keymap.set('n', '<Leader>Q', '<cmd>quitall!<cr>')

-- Search open buffers
vim.keymap.set('n', '<Leader><space>', '<cmd>ls<cr>:buffer ')

-- Close buffer
vim.keymap.set('n', '<Leader>bc', '<cmd>bdelete<cr>')

-- Close window
vim.keymap.set('n', '<Leader>bq', '<cmd>q<cr>')

-- Move to last active buffer
vim.keymap.set('n', '<Leader>bl', '<cmd>buffer #<cr>')

-- Show diagnostic message
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Go to previous diagnostic
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

-- Go to next diagnostic
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

-- Open file explorer
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<CR>')
vim.keymap.set('n', '<leader>E', '<cmd>Lexplore %:p:h<CR>')

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'user_cmds',
  desc = 'LSP actions',
  callback = function(ev)
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {buffer = ev.buf})
    end

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
  end
})


-- ========================================================================== --
-- ==                             USER PLUGINS                             == --
-- ========================================================================== --

vim.keymap.set('n', 'M', '<cmd>BufferNavMenu<cr>')
vim.keymap.set('n', '<leader>m', '<cmd>BufferNavMark<cr>')
vim.keymap.set('n', '<leader>M', '<cmd>BufferNavMark!<cr>')
vim.keymap.set('n', '<M-1>', '<cmd>BufferNav 1<cr>')
vim.keymap.set('n', '<M-2>', '<cmd>BufferNav 2<cr>')
vim.keymap.set('n', '<M-3>', '<cmd>BufferNav 3<cr>')
vim.keymap.set('n', '<M-4>', '<cmd>BufferNav 4<cr>')

vim.keymap.set({'', 't', 'i'}, '<C-t>', function()
  local direction = 'bottom'
  local size
  if vim.o.lines < 19 then
    direction = 'right'
    size = 0.4
  end

  require('user.terminal').toggle({direction = direction, size = size})
end)

