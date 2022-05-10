vim.config = {
	mapleader = ';', -- set a map <leader> for more key combos

	proxy = {
		github = true,
	},

	theme = 'onedarkpro',

	color = {
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

		darkCyan = '#002121',
		darkRed = '#340009',
		darkYellow = '#212100',
		darkOrange = '#371B00',
		darkPurple = '#180225',

		diffAddBG = '#13230c',
		diffDeleteBG = '#290005',
		diffChangeBG = '#212100',
		diffText = '#363537',

		blueBG = '#7D8CA3',
		yellowBG = '#F7B538',
		bg_d = '#1B1C1E',

		cursorLineBG = '#181928',
		cursorLineNrFG = '#689AFD',
	},

	ignoredFileTypesForSomePlugs = {
		'TelescopePrompt',
		'alpha', -- goolord/alpha-nvim, see plugins/dashboard.lua
		'lsp-installer',
		'null-ls-info',
		'lspinfo',
		'nerdtree',
		'aerial',
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

}
