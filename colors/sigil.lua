local color = {
  NONE = {gui = 'NONE',    cterm = 'NONE'},

  white   = {gui = '#D4BE98', cterm = 180},
  black   = {gui = '#1D2021', cterm = 234},
  green   = {gui = '#A9B665', cterm = 143},
  blue    = {gui = '#7DAEA3', cterm = 109},
  cyan    = {gui = '#89B482', cterm = 108},
  red     = {gui = '#EA6962', cterm = 167},
  magenta = {gui = '#D3869B', cterm = 174},
  yellow  = {gui = '#D8A657', cterm = 179},

  sad_blue      = {gui = '#5B8DD7', cterm = 109},
  orange        = {gui = '#BD6F3E', cterm = 131},
  light_green   = {gui = '#3D4C3E', cterm = 238},
  bright_black  = {gui = '#191C1D', cterm = 233},

  gray        = {gui = '#958272', cterm = 8  },
  light_gray  = {gui = '#212425', cterm = 235},
  bright_gray = {gui = '#2A2D2E', cterm = 236},
  dark_gray   = {gui = '#45494A', cterm = 235},
}

local theme = {
  BG = color.black,
  FG = color.white,
  line_bg = color.bright_black,
  selected_item = color.yellow,
  error = color.red,
  warning = color.yellow,
  info = color.cyan,
}

local function hi(group, colors)
  vim.api.nvim_set_hl(0, group, {
    fg = colors.fg.gui,
    bg = colors.bg.gui,
    ctermfg = colors.fg.cterm,
    ctermbg = colors.bg.cterm,
    underline = colors.underline
  })
end

local function link(group, og)
  vim.api.nvim_set_hl(0, group, {link = og})
end

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.opt.background = 'dark'
vim.g.colors_name = 'sigil'

local hi_none   = 'UserColorNone'
local hi_normal = 'UserColorNormal'

hi(hi_none,     {fg = color.NONE, bg = color.NONE})
hi(hi_normal,   {fg = theme.FG,   bg = color.NONE})

---
-- User Interface
---

hi('Normal',       {fg = theme.FG,        bg = theme.BG     })
hi('Statusline',   {fg = color.NONE,      bg = theme.line_bg})
hi('StatuslineNC', {fg = color.dark_gray, bg = theme.line_bg})
hi('TabLine',      {fg = color.NONE,      bg = theme.line_bg})
hi('TabLineFill',  {fg = color.NONE,      bg = theme.line_bg})
hi('VertSplit',    {fg = theme.line_bg,   bg = color.NONE   })
hi('TabLineSel',   {fg = color.NONE,      bg = theme.BG     })
hi('Underlined',   {fg = color.sad_blue,  bg = color.NONE   })
hi('ModeMsg',      {fg = color.NONE,      bg = color.NONE   })

hi('Pmenu',      {fg = color.NONE, bg = theme.BG           })
hi('PmenuSel',   {fg = color.NONE, bg = color.light_gray   })
hi('PmenuSbar',  {fg = color.NONE, bg = color.bright_gray  })
hi('PmenuThumb', {fg = color.NONE, bg = color.gray         })
hi('WildMenu',   {fg = theme.BG,   bg = theme.selected_item})

hi('Visual',     {fg = color.NONE,        bg = color.bright_gray                   })
hi('Search',     {fg = theme.FG,          bg = color.light_green                   })
hi('IncSearch',  {fg = theme.BG,          bg = theme.selected_item                 })
hi('CurSearch',  {fg = theme.BG,          bg = theme.selected_item                 })
hi('MatchParen', {fg = color.cyan,        bg = color.bright_gray,  underline = true})
hi('Conceal',    {fg = color.bright_gray, bg = color.NONE                          })

hi('Cursor',        {fg = theme.BG,        bg = theme.FG        })
hi('CursorLine',    {fg = color.NONE,      bg = color.light_gray})
hi('CursorLineNr',  {fg = color.NONE,      bg = theme.BG        })
hi('LineNr',        {fg = color.dark_gray, bg = color.NONE      })
hi('NonText',       {fg = color.dark_gray, bg = color.NONE      })
hi('EndOfBuffer',   {fg = color.dark_gray, bg = color.NONE      })

hi('Error',      {fg = color.red,     bg = color.NONE})
hi('MoreMsg',    {fg = color.green,   bg = color.NONE})
hi('Question',   {fg = color.green,   bg = color.NONE})
hi('Todo',       {fg = color.magenta, bg = color.NONE})

hi('Folded',      {fg = color.gray, bg = color.NONE})
hi('FoldColumn',  {fg = color.gray, bg = color.NONE})
hi('ColorColumn', {fg = color.NONE, bg = color.NONE})
hi('SignColumn',  {fg = color.NONE, bg = theme.BG  })

hi('DiffAdd',     {fg = color.green,  bg = color.NONE       })
hi('DiffChange',  {fg = color.yellow, bg = color.NONE       })
hi('DiffDelete',  {fg = color.red,    bg = color.NONE       })
hi('DiffText',    {fg = color.cyan,   bg = color.bright_gray})

hi('ErrorMsg',   {fg = theme.error,   bg = color.NONE})
hi('WarningMsg', {fg = theme.warning, bg = color.NONE})

hi('DiagnosticError', {fg = theme.error,   bg = color.NONE})
hi('DiagnosticWarn',  {fg = theme.warning, bg = color.NONE})
hi('DiagnosticInfo',  {fg = theme.info,    bg = color.NONE})
hi('DiagnosticHint',  {fg = theme.FG,      bg = color.NONE})


---
-- Base syntax
---
hi('Comment',    {fg = color.gray,      bg = color.NONE})
hi('Constant',   {fg = color.orange,    bg = color.NONE})
hi('String',     {fg = color.green,     bg = color.NONE})
hi('Character',  {fg = color.orange,    bg = color.NONE})
hi('Number',     {fg = color.orange,    bg = color.NONE})
hi('Float',      {fg = color.orange,    bg = color.NONE})
hi('Boolean',    {fg = color.orange,    bg = color.NONE})
hi('Function',   {fg = color.blue,      bg = color.NONE})
hi('Identifier', {fg = color.NONE,      bg = color.NONE})
hi('Statement',  {fg = color.NONE,      bg = color.NONE})
hi('PreProc',    {fg = color.NONE,      bg = color.NONE})
hi('Type',       {fg = color.NONE,      bg = color.NONE})
hi('Title',      {fg = color.NONE,      bg = color.NONE})
hi('Ignore',     {fg = color.NONE,      bg = color.NONE})
hi('Debug',      {fg = color.NONE,      bg = color.NONE})

hi('Delimiter',       {fg = theme.FG,       bg = color.NONE})
hi('Directory',       {fg = color.blue,     bg = color.NONE})
hi('cssClassName',    {fg = color.yellow,   bg = color.NONE})
hi('cssClassNameDot', {fg = color.yellow,   bg = color.NONE})
hi('htmlTag',         {fg = color.orange,   bg = color.NONE})
hi('htmlTagN',        {fg = color.orange,   bg = color.NONE})
hi('htmlEndTag',      {fg = color.orange,   bg = color.NONE})

link('Special',     hi_normal)
link('SpecialKey',  hi_normal)
link('helpExample', hi_normal)
link('netrwMarkFile', 'Search')

-- UI: window
link('FloatBorder', 'Normal')

-- UI: messages
link('Question', 'String')

-- Language: HTML
-- Syntax: built-in
link('htmlTagName',        'Function')
link('htmlSpecialTagName', 'Function')
link('htmlArg',            hi_none)
link('htmlLink',           hi_none)

-- Language: Javascript
-- Syntax: built-in
link('javaScriptNumber',   'Number')
link('javaScriptNull',     'Number')
link('javaScriptBraces',   hi_none)
link('javaScriptFunction', hi_none)

-- Language: Typescript
-- Syntax: built-in
link('typescriptParens', hi_normal)
link('typescriptBraces', hi_normal)
link('typescriptMember', hi_normal)

-- Language: PHP
-- Syntax: built-in
link('phpNullValue',       'Boolean')
link('phpSpecialFunction', 'Function')

-- Language: CSS
-- Syntax: built-in
link('cssTagName',           'Function')
link('cssColor',             'Number')
link('cssBraces',            hi_normal)

-- Treesitter (old highlight groups)
link('TSConstructor',     hi_normal)
link('TSVariableBuiltin', hi_normal)
link('TSConstBuiltin',    'Number')
link('TSFuncBuiltin',     'Function')
link('TSKeywordFunction', hi_normal)
link('luaTSPunctBracket', hi_normal)
link('luaTSConstant',     hi_normal)

--- Treesitter highlights
if vim.fn.has('nvim-0.9') == 1 then
  link('@function.call', 'Function')
  link('@function.builtin', 'Function')
  link('@constant.builtin', 'Number')
  link('@type.css', 'Function')
  link('@constructor.php', 'Function')
  link('@tag.delimiter', 'Constant')
  link('@tag.attribute', hi_none)
  link('@tag', 'Function')
  link('@text.uri.html', 'String')
  link('@text.literal', hi_none)
  link('@text.literal.vimdoc', hi_normal)

  link('@constant.lua', hi_normal)
  link('@constructor.lua', hi_normal)
  link('@constructor.javascript', 'Function')
end


---
-- Terminal
---
vim.g.terminal_color_foreground = theme.FG.gui
vim.g.terminal_color_background = theme.BG.gui

-- black
vim.g.terminal_color_0  = color.black.gui
vim.g.terminal_color_8  = color.bright_black.gui

-- red
vim.g.terminal_color_1  = color.red.gui
vim.g.terminal_color_9  = color.red.gui

-- green
vim.g.terminal_color_2  = color.green.gui
vim.g.terminal_color_10 = color.green.gui

-- yellow
vim.g.terminal_color_3  = color.yellow.gui
vim.g.terminal_color_11 = color.yellow.gui

-- blue
vim.g.terminal_color_4  = color.blue.gui
vim.g.terminal_color_12 = color.blue.gui

-- magenta
vim.g.terminal_color_5  = color.magenta.gui
vim.g.terminal_color_13 = color.magenta.gui

-- cyan
vim.g.terminal_color_6  = color.cyan.gui
vim.g.terminal_color_14 = color.cyan.gui

-- white
vim.g.terminal_color_7  = color.white.gui
vim.g.terminal_color_15 = color.white.gui


---
-- User plugin groups
---
local ok_s, statusline = pcall(require, 'user.statusline')

if ok_s then
  local status_group = statusline.higroups()

  hi(status_group['NORMAL'],  {fg = color.black, bg = color.blue   })
  hi(status_group['COMMAND'], {fg = color.black, bg = color.magenta})
  hi(status_group['INSERT'],  {fg = color.black, bg = color.green  })
  hi(status_group['DEFAULT'], {fg = color.black, bg = color.orange })
end

local ok_t, tabline = pcall(require, 'user.tabline')

if ok_t then
  local tab_group = tabline.higroups()

  link(tab_group['TABLINE-SEPARATOR'], 'Function')
end

