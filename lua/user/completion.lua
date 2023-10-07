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

function M.setup(opts)
  opts = opts or {}

  vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}
  vim.opt.shortmess:append('c')

  s.trigger = opts.toggle_menu or false
  s.tabcomplete = opts.tabcomplete or false

  local lsp_omnifunc = false
  if type(opts.lsp_omnifunc) == 'boolean' then
    lsp_omnifunc = opts.lsp_omnifunc
  end

  if s.tabcomplete then
    vim.keymap.set('i', '<Tab>', s.tab_fallback, {expr = true})
    vim.keymap.set('i', '<S-Tab>', s.tab_insert_or_prev, {expr = true})
  end

  if s.trigger then
    vim.keymap.set(
      'i',
      s.trigger,
      s.toggle_menu_fallback,
      {expr = true, remap = false}
    )
  end

  local group = vim.api.nvim_create_augroup('user_omnifunc', {clear = true})

  if lsp_omnifunc == false then
    return
  end

  local lsp_attach_event = 'LspAttach'
  local lsp_attach_pattern

  if vim.lsp.start == nil then
    lsp_attach_event = 'User'
    lsp_attach_pattern = 'LspAttached'
  end

  local on_attach = M.on_attach
  vim.api.nvim_create_autocmd(lsp_attach_event, {
    pattern = lsp_attach_pattern,
    group = group,
    desc = 'setup LSP omnifunc completion',
    callback = function(ev) on_attach(ev.buf) end,
  })
end

function M.on_attach(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local buf_opts = {buffer = bufnr, expr = true, remap = false}

  if s.tabcomplete then
    vim.keymap.set('i', '<Tab>', s.tab_expr, buf_opts)
  end

  if s.trigger then
    vim.keymap.set('i', s.trigger, s.toggle_menu, buf_opts)
  end
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

