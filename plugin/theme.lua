if vim.g.user_theme ~= nil then
  return
end

vim.g.user_theme = 1
vim.opt.termguicolors = true

vim.cmd('colorscheme sigil')

require('user.statusline').setup()
require('user.tabline').setup()

