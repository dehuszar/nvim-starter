local M = {}
local s = {}

local augroup = vim.api.nvim_create_augroup('session_cmds', {clear = true})
local autocmd_id

function M.setup()
  local command = vim.api.nvim_create_user_command

  command('SessionSave', s.save_current, {})
  command('SessionConfig', s.session_config, {})
  command('SessionNew', s.create, {nargs = '?', complete = 'file'})
  command('SessionLoad', s.load, {nargs = '?', complete = 'file'})
end

function s.mksession(path, bang)
  local exec = 'mksession%s %s'
  local file = vim.fn.fnameescape(path)
  vim.cmd(exec:format(bang and '!' or '', file))
end

function s.save_current()
  local file = vim.v.this_session
  if file == '' then
    return
  end

  s.mksession(file, true)
end

function s.autosave()
  if autocmd_id then
    return
  end

  autocmd_id = vim.api.nvim_create_autocmd('VimLeavePre', {
    group = augroup,
    desc = 'Save active session on exit',
    callback = s.save_current
  })
end

function s.load(input)
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
    s.mksession(file, true)
  end

  file = vim.fn.fnameescape(path)
  local exec = 'source %s'
  vim.cmd(exec:format(file))
  s.autosave()
end

function s.create(input)
  local path = input.args
  if path == '' and vim.g.user_session_path then
    path = vim.g.user_session_path
  end

  if path == nil or path == '' then
    local msg = 'Must specify the path to a session file'
    vim.notify(msg, vim.log.levels.WARN)
    return
  end

  s.mksession(path)
  s.autosave()
end

function s.session_config()
  local file = vim.v.this_session
  if file == '' then
    return
  end

  local path = vim.fn.fnamemodify(file, ':r')
  file = vim.fn.fnameescape(path .. 'x.vim')
  local exec = 'edit %s'

  vim.cmd(exec:format(file))
end

return M

