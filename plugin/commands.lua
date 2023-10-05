require('user.netrw').setup()
require('user.session').setup()
require('user.terminal').setup()
require('user.buffer-nav').setup()

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.api.nvim_create_user_command(
  'GetSelection',
  function()
    local f = vim.fn
    local temp = f.getreg('s')
    vim.cmd('normal! gv"sy')

    f.setreg('/', f.escape(f.getreg('s'), '/'):gsub('\n', '\\n'))

    f.setreg('s', temp)
  end,
  {desc = 'Add selected text to the search register'}
)

vim.api.nvim_create_user_command(
  'TrailspaceTrim',
  function()
    -- Save cursor position to later restore
    local curpos = vim.api.nvim_win_get_cursor(0)

    -- Search and replace trailing whitespace
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
  {desc = 'Delete extra whitespace'}
)

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

