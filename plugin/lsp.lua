if vim.g.user_lsp_loaded ~= nil then
  return
end

vim.g.user_lsp_loaded = 1

vim.opt.signcolumn = 'yes'

require('user.completion').setup({
  lsp_omnifunc = true,
  tabcomplete = true,
  toggle_menu = '<C-e>',
})

local lsp = require('user.lsp-client')

lsp.ui({
  border = 'rounded',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  }
})

vim.api.nvim_create_user_command(
  'LspFormat',
  lsp.format_command,
  {nargs = '?', bang = true, range = true}
)

lsp.new_client({
  name = 'lua_ls',
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_dir = lsp.root_pattern({'.luarc.json'}),
  on_attach = function(client, bufnr)
    -- enable format on save
    lsp.buffer_autoformat(client, bufnr)
  end,
  settings = {
    Lua = {
      -- Neovim's omnifunc doesn't support snippets
      completion = {keywordSnippet = 'Disable'},
    }
  },
})

lsp.new_client({
  name = 'tsserver',
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  root_dir = function()
    return lsp.find_first({'package.json'})
  end,
})

