if vim.g.user_lsp_loaded ~= nil then
  return
end

vim.g.user_lsp_loaded = 1

vim.opt.signcolumn = 'yes'
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

local lsp = require('user.lsp-client')

require('user.completion').tab_complete()

lsp.new_client({
  name = 'lua_ls',
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_dir = function()
    return lsp.find_first({'.luarc.json'})
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

