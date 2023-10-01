require('user.netrw').setup()
require('user.buffer-nav').setup()
require('user.terminal').setup()

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'user_cmds',
  desc = 'Highlight on yank',
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 80})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = 'user_cmds',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

