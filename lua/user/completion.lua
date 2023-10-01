local M = {}
local s = {}

local action = {
  omni_complete = '<C-x><C-o>',
  buffer_complete = '<C-x><C-n>',
  next_item = '<Down>',
  prev_item = '<Up>',
}

local pumvisible = vim.fn.pumvisible

function M.tab_complete()
  vim.opt.shortmess:append('c')

  vim.keymap.set('i', '<Tab>', s.tab_fallback, {expr = true})
  vim.keymap.set('i', '<S-Tab>', s.tab_insert_or_prev, {expr = true})

  local group = vim.api.nvim_create_augroup('user_omnifunc', {clear = true})
  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'setup LSP omnifunc completion',
    callback = function(ev)
      local opts = {buffer = ev.buf, expr = true}
      vim.keymap.set('i', '<Tab>', s.tab_expr, opts)
    end
  })
end

function s.tab_insert_or_prev()
  if pumvisible() == 1 then
    return action.prev_item
  end

  return '<Tab>'
end

function s.tab_fallback()
  if pumvisible() == 1 then
    return action.next_item
  end

  if s.has_words_before() then
    return action.buffer_complete
  end

  return '<Tab>'
end

function s.tab_expr()
  if pumvisible() == 1 then
    return action.next_item
  end

  if s.has_words_before() then
    return action.omni_complete
  end

  return '<Tab>'
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

