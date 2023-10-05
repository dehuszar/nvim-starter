local M = {}
local user_attach

function M.attached(client, bufnr)
  vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  if user_attach then
    user_attach(client, bufnr)
  end
end

function M.on_attach(fn)
  if type(fn) == 'function' then
    user_attach = fn
  end
end

function M.new_client(opts)
  if opts.filetypes == nil then
    return
  end

  local setup_id
  local desc = 'Attach LSP server'
  local defaults = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_exit = vim.schedule_wrap(function()
      if setup_id then
        pcall(vim.api.nvim_del_autocmd, setup_id)
      end
    end),
    on_attach = function(client, bufnr) M.attached(client, bufnr) end,
  }

  local config = vim.tbl_deep_extend('force', defaults, opts)

  local get_root = opts.root_dir
  if type(get_root) == 'function' then
    config.root_dir = nil
  end

  if opts.on_exit then
    local cb = opts.on_exit
    local cleanup = defaults.on_exit
    config.on_exit = function(...)
      cleanup()
      cb(...)
    end
  end

  if opts.on_attach then
    local cb = opts.on_attach
    config.on_attach = function(...)
      M.attached()
      cb(...)
    end
  end

  if config.name then
    desc = string.format('Attach LSP: %s', config.name)
  end

  local id

  local attach_client = function(input)
    if get_root then
      config.root_dir = get_root()
    end

    if id == nil then
      id = vim.lsp.start_client(config)
    end

    if id and config.root_dir then
      vim.lsp.buf_attach_client(input.buf, id)
    end
  end

  setup_id = vim.api.nvim_create_autocmd('FileType', {
    group = M.lsp_cmds,
    pattern = config.filetypes,
    desc = desc,
    callback = attach_client
  })

  local ft = config.filetypes

  if type(ft) == 'string' then
    ft = {config.filetypes}
  end

  if vim.tbl_contains(ft, vim.bo.filetype) then
    attach_client({buf = 0})
  end
end

return M

