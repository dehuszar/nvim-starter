local M = {}
local s = {}

local action = {
  omni_complete = '<C-x><C-o>',
  buffer_complete = '<C-x><C-n>',
  next_item = '<Down>',
  prev_item = '<Up>',
  abort = '<C-e>',
  insert_tab = '<Tab>',
}

local pumvisible = vim.fn.pumvisible
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

function M.setup(opts)
  opts = opts or {}
  vim.opt.shortmess:append('c')

  local trigger = opts.toggle_menu or false
  local tabcomplete = opts.tabcomplete or false

  if tabcomplete then
    vim.keymap.set('i', '<Tab>', s.tab_fallback, {expr = true})
    vim.keymap.set('i', '<S-Tab>', s.tab_insert_or_prev, {expr = true})
  end

  if trigger then
    vim.keymap.set(
      'i',
      trigger,
      s.toggle_menu_fallback,
      {expr = true, remap = false}
    )
  end

  local group = vim.api.nvim_create_augroup('user_omnifunc', {clear = true})

  local lsp_attach_event = 'LspAttach'
  local lsp_attach_pattern

  if vim.lsp.start == nil then
    lsp_attach_event = 'User'
    lsp_attach_pattern = 'LspAttached'
  end

  M.on_attach = function(ev)
    local buf_opts = {buffer = ev.buf, expr = true, remap = false}

    if tabcomplete then
      vim.keymap.set('i', '<Tab>', s.tab_expr, buf_opts)
    end

    if trigger then
      vim.keymap.set('i', trigger, s.toggle_menu, buf_opts)
    end
  end

  vim.api.nvim_create_autocmd(lsp_attach_event, {
    pattern = lsp_attach_pattern,
    group = group,
    desc = 'setup LSP omnifunc completion',
    callback = M.on_attach,
  })
end

function s.tab_insert_or_prev()
  if pumvisible() == 1 then
    return action.prev_item
  end

  return action.insert_tab
end

function s.toggle_menu()
  if pumvisible() == 1 then
    return action.abort
  end

  return action.omni_complete
end

function s.toggle_menu_fallback()
  if pumvisible() == 1 then
    return action.abort
  end

  return action.buffer_complete
end

function s.tab_fallback()
  if pumvisible() == 1 then
    return action.next_item
  end

  if s.has_words_before() then
    return action.buffer_complete
  end

  return action.insert_tab
end

function s.tab_expr()
  if pumvisible() == 1 then
    return action.next_item
  end

  if s.has_words_before() then
    return action.omni_complete
  end

  return action.insert_tab
end

function s.has_words_before()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local col = cursor[2]

  if col == 0 then
    return false
  end

  local line = cursor[1]
  local str = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]

  return str:sub(col, col):match('%s') == nil
end

return M

