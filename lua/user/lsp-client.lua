local M = {}
local augroup = vim.api.nvim_create_augroup
local lsp_cmds = augroup('lsp_cmds', {clear = true})
local format_cmds = augroup('lsp_autoformat_cmds', {clear = true})

function M.new_client(opts)
  local setup_id
  local desc = 'Attach LSP server'
  local defaults = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_exit = vim.schedule_wrap(function()
      if setup_id then
        pcall(vim.api.nvim_del_autocmd, setup_id)
      end
    end),
  }

  local config = vim.tbl_deep_extend('force', defaults, opts)

  if config.filetypes == nil then
    return
  end

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

  if config.name then
    desc = string.format('Attach LSP: %s', config.name)
  end

  local start_client = function()
    if get_root then
      config.root_dir = get_root()
    end

    if config.root_dir then
      vim.lsp.start(config)
    end
  end

  setup_id = vim.api.nvim_create_autocmd('FileType', {
    group = lsp_cmds,
    pattern = config.filetypes,
    desc = desc,
    callback = start_client
  })
end

function M.find_first(list)
  local result = vim.fs.find(list, {
    upward = true,
    limit = 1,
    stop = vim.env.HOME,
  })

  local path = result[1]

  if path == nil then
    return
  end

  if vim.fn.isdirectory(path) == 1 then
    return path
  end

  return vim.fs.dirname(path)
end

function M.ui(opts)
  opts = opts or {}
  local border = opts.border
  local icons = opts.sign_icons

  if type(border) == 'string' then
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      {border = border}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {border = border}
    )
  end

  if type(icons) == 'table' then
    local sign = function(args)
      if args.text == nil then
        return
      end

      vim.fn.sign_define(args.name, {
        texthl = args.name,
        text = args.text,
        numhl = ''
      })
    end

    sign({name = 'DiagnosticSignError', text = icons.error})
    sign({name = 'DiagnosticSignWarn', text = icons.warn})
    sign({name = 'DiagnosticSignHint', text = icons.hint})
    sign({name = 'DiagnosticSignInfo', text = icons.info})
  end
end

function M.buffer_autoformat(client, bufnr, opts)
  local timeout_ms = 10000

  opts = opts or {}
  client = client or {}
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.api.nvim_clear_autocmds({group = format_cmds, buffer = bufnr})

  local config = {
    async = false,
    id = client.id,
    name = client.name,
    bufnr = bufnr,
    timeout_ms = opts.timeout_ms or timeout_ms,
    formatting_options = opts.formatting_options,
  }

  local apply_format = function()
    vim.lsp.buf.format(config)
  end

  local desc = 'Format current buffer'

  if client.name then
    desc = string.format('Format buffer with %s', client.name)
  end

  vim.api.nvim_create_autocmd('BufWritePre', {
    group = format_id,
    buffer = bufnr,
    desc = desc,
    callback = apply_format
  })
end

return M

