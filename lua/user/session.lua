local M = {}

local augroup = vim.api.nvim_create_augroup('session_cmds', {clear = true})
local autocmd_id

function M.setup()
  local command = vim.api.nvim_create_user_command

  command('SessionSave', M.save_current, {})
  command('SessionConfig', M.session_config, {})
  command('SessionNew', M.create, {nargs = '?', complete = 'file'})
  command('SessionLoad', M.load, {nargs = '?', complete = 'file'})
end

function M.save_current()
  local file = vim.v.this_session
  if file == '' then
    return
  end

  vim.cmd.mksession({args = {file}, bang = true})
end

function M.autosave()
  if autocmd_id then
    return
  end

  autocmd_id = vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    desc = 'Save active session on exit',
    callback = M.save_current
  })
end

function M.load(input)
  local path = input.args
  if path == '' and vim.g.user_session_path then
    path = vim.g.user_session_path
  end

  if path == nil or path == '' then
    local msg = 'Must specify the path to a session file'
    vim.notify(msg, vim.log.levels.WARN)
    return
  end

  local file = vim.v.this_session
  if #file > 0 then
    -- save current session
    vim.cmd.mksession({args = {file}, bang = true})
  end

  vim.cmd.source(path)
  M.autosave()
end

function M.create(input)
  local path = input.args
  if path == '' and vim.g.user_session_path then
    path = vim.g.user_session_path
  end

  if path == nil or path == '' then
    local msg = 'Must specify the path to a session file'
    vim.notify(msg, vim.log.levels.WARN)
    return
  end

  vim.cmd.mksession({args = {path}})
  M.autosave()
end

function M.session_config()
  local file = vim.v.this_session
  if file == '' then
    return
  end

  local path = vim.fn.fnamemodify(file, ':r')
  vim.cmd.edit({args = {path .. 'x.vim'}})
end

return M

