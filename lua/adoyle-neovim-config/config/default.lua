-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.
return function(color)
	local defaultSymbol = require('adoyle-neovim-config.config.symbol')

	return {
		mapleader = ';', -- Set a map <leader> for more key combos

		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
			github = '', -- emptry string or proxy url
		},

		theme = 'onedarkpro',

		-- All plugins are downloaded in this directory
		-- Default: ~/.local/share/nvim/plugins
		pluginDir = vim.fn.stdpath('data') .. '/plugins',

		pluginOpts = { -- Override plugin default config
			-- ['plugins.profiling'] = {
			--   disable = false, -- Set false to enable the disabled plugin by default.
			-- },

			-- ['psliwka/vim-smoothie'] = {
			--   disable = false,
			-- },
		},

		-- Add your plugins. More examples at ./lua/adoyle-neovim-config/plugins.lua
		plugins = {
			-- { 'psliwka/vim-smoothie', disable = false },

			-- function(Plug)
			--   Plug { 'psliwka/vim-smoothie', disable = false }
			-- end,
		},

		lsp = require('adoyle-neovim-config.config.lsp'),

		color = color,

		highlights = require('adoyle-neovim-config.config.highlight-group')(color),

		ignoredFileTypesForSomePlugs = {
			'TelescopePrompt',
			'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
			'lsp-installer',
			'null-ls-info',
			'lspinfo',
			'nerdtree',
			'aerial',
			'Mundo',
			'mason',
		},

		colorcolumn = {}, -- highlight columns. See ":h 'cc'"

		synmaxcol = 300, -- Syntax coloring lines that are too long just slows down the world

		updatetime = 5000, -- auto save the swap every <updatetime> seconds

		updatecount = 100, -- auto save the swap every <updatecount> characters

		foldenable = true, -- auto fold code

		linenumber = true, -- show linenumber. :h 'linenumber'

		signcolumn = 'auto:2',

		cmdheight = 2, -- cmd line height. :h 'cmdheight'

		history = 1000, --  how many entries may be stored in each of these histories. :h 'history'

		diagnosticBorder = { -- See the border property of ":h nvim_open_win"
			{ '╭', 'DiagnosticBorder' },
			{ '─', 'DiagnosticBorder' },
			{ '╮', 'DiagnosticBorder' },
			{ '│', 'DiagnosticBorder' },
			{ '╯', 'DiagnosticBorder' },
			{ '─', 'DiagnosticBorder' },
			{ '╰', 'DiagnosticBorder' },
			{ '│', 'DiagnosticBorder' },
		},

		-- diagnosticBorder = {
		--   { '╔', 'DiagnosticBorder' },
		--   { '═', 'DiagnosticBorder' },
		--   { '╗', 'DiagnosticBorder' },
		--   { '║', 'DiagnosticBorder' },
		--   { '╝', 'DiagnosticBorder' },
		--   { '═', 'DiagnosticBorder' },
		--   { '╚', 'DiagnosticBorder' },
		--   { '║', 'DiagnosticBorder' },
		-- },

		fillchars = { -- window border. :h 'fcs'
			vert = '│',
			diff = '╱',
		},

		-- listchars = 'tab:——,space:·,eol:¬,trail:·,extends:⇢,precedes:⇠,nbsp:+', -- 高亮空格、Tab、换行符等
		listchars = { -- :h 'listchars'
			tab = '——',
			space = '·',
			eol = '¬', -- show at the end of each line
			lead = '·', -- show for leading spaces
			trail = '·', -- trailing spaces
			extends = '⇢', -- show in last column
			precedes = '⇠', -- show in the first visible
			nbsp = '+', -- show for a non-breakable space character
		},

		linebreakChar = '↪', -- :h 'showbreak'

		langmenu = 'zh_CN.UTF-8', -- :h 'langmenu'

		spell = {
			check = false,
			lang = { 'en', 'cjk' }, -- :h 'spelllang'
			suggest = { 'best', 6 }, -- :h 'spellsuggest'
		},

		matchpairs = { -- Press % to jump from one to the other. :h 'matchpairs'
			-- LuaFormatter off
			'(:)', '{:}', '[:]', '「:」', '<:>', '“:”',
			-- LuaFormatter on
		},

		systemClipboard = false, -- paste and copy in vim with system clipboard

		guicursor = { -- :h 'guicursor'. But nvim has many bug on guicursor
			'n-v-c-sm:block-MyCursor', -- block cursor with colors from the "MyCursor" highlight group
			'i-ci-ve:ver25-MyCursor',
			'r-cr-o:hor20',
		},

		fileencodings = { 'utf-8', 'gb2312', 'gbk', 'ucs-bom', 'default', 'latin1' },

		fileformats = { 'unix', 'dos', 'mac' },

		treesitter = {
			ensure_installed = {}, -- A list of parser names, or "all"
			sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
			ignore_install = { 'rasi', 'r', 'd', 'v', 'slint' }, -- List of parsers to ignore installing (for "all")

			highlight = {
				enable = true, -- `false` will disable the whole extension

				-- list of language that will be disabled.
				-- NOTE: these are the names of the parsers and not the filetype.
				-- (for example if you want to disable highlighting for the `tex` filetype,
				-- you need to include `latex` in this list as this is the name of the parser)
				disable = { 'markdown' },
			},
		},

		symbolMap = defaultSymbol.symbolMap,

		kindSymbolMap = defaultSymbol.kindSymbolMap,

		codeContext = { -- show code context which parsed by treesitter
			winbar = true, -- show context path in winbar
			float = true, -- show context funciton float on top
		},

		indentLine = {
			line = '⎜', -- '┊', '', '⎸', '│', '⎜', '⎜', '⎜'
			inactive = { fg = color.grey1 },
			active = { fg = color.purple },
			excludeFileType = {
				'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
			},
		},

		tsRainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			colors = { -- table of hex strings
				-- LuaFormatter off
				'#005f87', '#d75f00', '#12ff5f', '#0087ff', '#00aa87', '#b2ffaf', '#ff5f00',
				'#6F3080', '#ff00ff', '#8787ff', '#87875f',
				-- LuaFormatter on
			},

			termcolors = { -- table of colour name strings
			},
		},
	}
end
