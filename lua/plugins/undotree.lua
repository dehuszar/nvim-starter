local Plugin = {'mbbill/undotree'}

Plugin.name = 'undotree'

Plugin.cmd = {'UndoTreeToggle'}

Plugin.opts = {
}

function Plugin.init()
  vim.keymap.set('n', '<leader>t', '<cmd>UndotreeToggle<cr>')
end

return Plugin

