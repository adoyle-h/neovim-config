local util = require('adoyle-neovim-config.util')

-- Set default options for vim/nvim. Use :help 'option' to see the documentation for the given option.
local default = { 'vim' }

local opt = vim.opt

default.g = {
	-- Set the default listing style:
	-- = 0: thin listing (one file per line)
	-- = 1: long listing (one file per line with time
	--      stamp information and file size)
	-- = 2: wide listing (multiple files in columns)
	-- = 3: tree style listing
	netrw_liststyle = 3,

	netrw_winsize = 30,

	netrw_nogx = 1, -- disable netrw's gx mapping. I use open-browser.vim
}

default.opt = {
	shell = vim.env.SHELL,

	-- Default nvim statusline (If statusline plugin disabled)
	statusline = '%F%m%r%h%w [FORMAT=%{&ff}] [TYPE=%Y] [POS=%l,%v][%p%%] %{strftime(\"%d/%m/%y - %H:%M\")}',
	shortmess = 'ilmnrxsW', -- helps to avoid all the hit-enter prompts caused by file messages
	showmode = true,

	cmdheight = 2, -- cmd line height. :h 'cmdheight'
	number = true, -- show line number
	relativenumber = true, -- show relative line number
	-- wrap = false, -- line wrapping
	-- linebreak = true, -- set soft wrapping
	textwidth = 0, -- Maximum width of text to wrap
	diffopt = opt.diffopt + { 'vertical' },
	compatible = false, -- not compatible Vi. Default "nocompatible" in nvim. DO NOT CHANGE THIS OPTION.

	hidden = false, -- current buffer can be put into background"
	lazyredraw = true, -- don't update the display while executing macros
	autoread = true, -- detect when a file is changed
	whichwrap = 'b,s', -- 允许 backspace 和空格键跨越行边界
	backspace = { 'indent', 'eol', 'start' }, -- 使 backspace 正常处理 indent, eol, start 等
	smartindent = true,
	autoindent = true, -- Indent at the same level of the previous line
	laststatus = 2, -- always show status line
	-- If 0, move cursor line will not scroll window.
	-- If 999, cursor line will always be in middle of window.
	scrolloff = 0,
	report = 0, -- always show messages when lines changed
	more = true,
	showmatch = true, -- show matching bracket (briefly jump)
	matchtime = 1, -- show matching bracket for 0.2 seconds
	formatoptions = opt.formatoptions + 'mB',
	conceallevel = 2,
	concealcursor = '',
	termguicolors = true, -- Require true color
	background = 'dark', -- Dark theme. DO NOT CHANGE THIS OPTION.

	showcmd = true, -- Show (partial) command in the last line of the screen
	list = false, -- Do not show listchars

	completeopt = {
		'menu', -- Use a popup menu to show the possible completions.
		'menuone', -- Use the popup menu also when there is only one match.
		'noselect', -- Do not select a match in the menu, force the user to select one from the menu.
		'noinsert', -- Do not insert any text for a match until the user selects a match from the menu.
	},

	-- Window
	winwidth = 10, --  min width of current window
	winminwidth = 1, --  min width of inactive window

	-- When true, all the windows are automatically made the same size after splitting or closing a window.
	-- When false, splitting a window will reduce the size of the current window and leave the other windows the same.
	equalalways = false,

	-- set ignore file extension of wildmenu, won't list when using filename completion
	wildignore = opt.wildignore + {
		-- LuaFormatter off
		'*.a', '*.o', '.DS_Store', '.git', '.hg', '.svn', '*~', '*.swp', '*.tmp', '*/.sass-cache/*', '*.scssc',
		-- LuaFormatter on
	},
	wildmode = { 'list', 'full' }, -- Command <Tab> completion, list matches, then longest common part, then all.

	-- Edit
	tabstop = 4, -- Default tab width. The tabstop should equal to shiftwidth
	shiftwidth = 4, -- Default shift spaces width
	softtabstop = 4, -- Number of spaces that a <Tab> counts for while performing editing operations.
	shiftround = true, -- Round indent to multiple of 'shiftwidth'.
	expandtab = true, -- Use the appropriate number of spaces to insert a <Tab>
	smarttab = true,
	iskeyword = opt.iskeyword - { '.' },

	ruler = true, -- 打开状态栏标尺
	confirm = true, -- 在处理未保存或只读文件的时候，弹出确认
	ttimeout = true, -- prevent '<esc>' delay in terminal http://stackoverflow.com/a/33957679/2326199
	timeoutlen = 99999, -- 一直等待组合键完成
	scrolljump = 1, -- Lines to scroll when cursor leaves screen

	-- Folding
	foldcolumn = '0', -- To disable foldcolumn
	-- manual    手工折叠
	-- indent    使用缩进表示折叠
	-- expr      使用表达式定义折叠
	-- syntax    使用语法定义折叠
	-- diff      对没有更改的文本进行折叠
	-- marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
	foldmethod = 'indent',
	foldlevel = 99,

	-- Mouse
	mouse = 'nvc',
	mousemodel = 'popup',
	selection = 'exclusive',

	-- Searching
	ignorecase = true, -- case insensitive searching
	smartcase = true, -- case-sensitive if expresson contains a capital letter
	inccommand = 'split', -- neovim feature: live preview

	-- Error Bell
	errorbells = false,
	visualbell = true,

	history = 1000, --  how many entries may be stored in each of these histories. :h 'history'
	colorcolumn = {}, -- highlight columns. See ":h 'cc'"
	signcolumn = 'auto:2', -- max 2 columns for signs
	synmaxcol = 500, -- syntax coloring lines that are too long just slows down the performance
	updatetime = 5000, -- auto save the swap every <updatetime> seconds
	updatecount = 100, -- auto save the swap every <updatecount> characters
	foldenable = true, -- auto fold code

	fillchars = { -- :h 'fcs'
		vert = '│', -- vertical separator for window border
		diff = '╱', -- deleted lines for diff view
	},

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

	showbreak = '↪', -- :h 'showbreak'
	langmenu = 'zh_CN.UTF-8', -- :h 'langmenu'

	matchpairs = { -- Press % to jump from one to the other. :h 'matchpairs'
		-- LuaFormatter off
		'(:)', '{:}', '[:]', '「:」', '<:>', '“:”',
		-- LuaFormatter on
	},

	-- :h 'guicursor'. If your guicursor not changed, see ":h tui-cursor-shape" and ":h tui-cursor-tmux"
	guicursor = {
		-- 'a:block-MyCursor',
		'n-v-c-sm:block-MyCursor', -- block cursor with colors from the "MyCursor" highlight group
		'i-ci-ve:ver25-MyCursor',
		'r-cr-o:hor20',
	},

	cursorcolumn = false,
	cursorline = true, -- highlight current line

	fileencodings = { 'utf-8', 'gb2312', 'gbk', 'ucs-bom', 'default', 'latin1' },

	fileformats = { 'unix', 'dos', 'mac' },

	spell = false,
	spellfile = util.configPath('spell/en.utf-8.add'),
	spelllang = { 'en', 'cjk' }, -- :h 'spelllang'
	spellsuggest = { 'best', 6 }, -- :h 'spellsuggest'

	-- paste and copy in vim with system clipboard
	-- clipboard = opt.clipboard + { 'unnamed' },
}

default.cmd = {
	[[
		syntax on " turn on that syntax highlighting. Default is on in neovim.

		" command                       detection   plugin      indent ~
		" :filetype on                  on          unchanged   unchanged
		" :filetype off                 off         unchanged   unchanged
		" :filetype plugin on           on          on          unchanged
		" :filetype plugin off          unchanged   off         unchanged
		" :filetype indent on           on          unchanged   on
		" :filetype indent off          unchanged   unchanged   off
		" :filetype plugin indent on    on          on          on
		" :filetype plugin indent off   unchanged   off         off

		filetype on  " 侦测文件类型
		filetype plugin on " 载入文件类型插件
		filetype indent on " 为特定文件类型载入相关缩进文件
		filetype plugin indent on
	]],
}

return {
	'vim',

	desc = 'Set vim/nvim options. Use :help "option" to see the documentation for the given option.',
	defaultConfig = { 'vim', default },

	config = function(config)
		local o = vim.opt
		local g = vim.g
		local cmd = vim.cmd

		for key, value in pairs(config.vim.g) do g[key] = value end
		for key, value in pairs(config.vim.opt) do o[key] = value end
		for _, value in pairs(config.vim.cmd) do cmd(value) end
	end,
}
