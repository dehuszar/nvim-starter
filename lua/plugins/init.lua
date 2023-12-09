local Plugins = {
  {'tpope/vim-fugitive'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},
  {'kyazdani42/nvim-web-devicons', lazy = true},
  {'numToStr/Comment.nvim', config = true, event = 'VeryLazy'},
	{
		'rbong/vim-flog',
		lazy = true,
		cmd = { "Flog", "FlogSplit", "Floggit" },
		dependencies = {
			{'tpope/vim-fugitive'},
		},
	},

  -- Themes
  {'folke/tokyonight.nvim'},
  {'joshdick/onedark.vim'},
  {'tanvirtin/monokai.nvim'},
  {'lunarvim/darkplus.nvim'},
}

return Plugins
