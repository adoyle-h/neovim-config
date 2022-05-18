-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.

local color = {
	white = '#BEC0C4',
	black = '#101012',
	grey1 = '#18191B',
	grey2 = '#242629',
	grey3 = '#34373B',
	green = '#75C44E',
	orange = '#D75F00',
	blue = '#689AFD',
	cyan = '#9AC3DE',
	-- purple = '#574AB2',
	purple = '#765ADA',
	-- yellow = '#E3D888',
	yellow = '#C3B11A',
	red = '#BF3100',
	grey = '#6C6F7F',

	lightGrey = '#818387',

	darkBlue = '#181928',
	darkCyan = '#002121',
	darkRed = '#340009',
	darkYellow = '#212100',
	darkOrange = '#371B00',
	darkPurple = '#180225',
}

for k, v in pairs({
	diffAddBG = '#13230c',
	diffDeleteBG = '#290005',
	diffChangeBG = color.darkYellow,
	diffText = '#363537',

	blueBG = '#7D8CA3',
	yellowBG = '#F7B538',
	bg_d = '#1B1C1E',

	cursorLineBG = color.darkBlue,
	cursorLineNrFG = color.blue,
	scrollbarBG = color.grey2,
}) do color[k] = v end

return {
	mapleader = ';', -- Set a map <leader> for more key combos

	proxy = {
		-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
		github = '', -- emptry string or proxy url
	},

	theme = 'onedarkpro',

	pluginDir = vim.fn.stdpath('data') .. '/plugins', -- All plugins are downloaded in this directory

	pluginOpts = { -- Override plugin default config
		-- ['plugins.profiling'] = {
		--   disable = false, -- Set false to enable the disabled plugin by default.
		-- },

		-- ['psliwka/vim-smoothie'] = {
		--   disable = false,
		-- },
	},

	plugins = { -- Set your plugins
		-- { 'psliwka/vim-smoothie', disable = false },

		-- function(Plug)
		--   Plug { 'psliwka/vim-smoothie', disable = false }
		-- end,
	},

	lsp = { -- Change lsp.setup(opts). Format: {['lsp_name'] = function(opts)}
		-- sumneko_lua = function(opts)
		--   opts.settings = {
		--     Lua = {
		--       diagnostics = {
		--         globals = {}
		--       }
		--     }
		--   }
		-- end
	},

	color = color,

	ignoredFileTypesForSomePlugs = {
		'TelescopePrompt',
		'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
		'lsp-installer',
		'null-ls-info',
		'lspinfo',
		'nerdtree',
		'aerial',
		'Mundo',
	},

	highlightColumns = { 80, 100 }, -- :h 'cc'

	synmaxcol = 300, -- Syntax coloring lines that are too long just slows down the world

	updatetime = 5000, -- auto save the swap every <updatetime> seconds

	updatecount = 100, -- auto save the swap every <updatecount> characters

	foldenable = true, -- auto fold code

	linenumber = true, -- show linenumber. :h 'linenumber'

	cmdheight = 2, -- cmd line height. :h 'cmdheight'

	history = 1000, --  how many entries may be stored in each of these histories. :h 'history'

	fillchars = { -- window border. :h 'fcs'
		vert = '│',
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
		'(:)', '{:}', '[:]', '<:>', '“:”',
	},

	systemClipboard = false, -- paste and copy in vim with system clipboard

	guicursor = { -- :h 'guicursor'
		'n-v-c-sm:block-MyCursor',
		'i-ci-ve:ver25-MyCursor',
		'r-cr-o:hor20',
	},

	highlights = {
		MyCursor = vim.fn.printf('guibg=%s', color.blue),
	},

	fileencodings = { 'utf-8', 'gb2312', 'gbk', 'ucs-bom', 'default', 'latin1' },

	fileformats = { 'unix', 'dos', 'mac' },

	treesitter = {
		ensure_installed = {}, -- A list of parser names, or "all"
		sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
		ignore_install = { 'phpdoc', 'php', 'rasi', 'd' }, -- List of parsers to ignore installing (for "all")

		highlight = {
			enable = true, -- `false` will disable the whole extension

			-- list of language that will be disabled.
			-- NOTE: these are the names of the parsers and not the filetype.
			-- (for example if you want to disable highlighting for the `tex` filetype,
			-- you need to include `latex` in this list as this is the name of the parser)
			disable = { 'markdown' },
		},
	},
}
