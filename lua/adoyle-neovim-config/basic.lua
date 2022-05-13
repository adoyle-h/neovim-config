local config = require('adoyle-neovim-config.config').getGlobal()
local util = require('adoyle-neovim-config.util')

-- Set default options for vim/nvim. Use :help 'option' to see the documentation for the given option.
-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

-- set a map <leader> for more key combos
vim.g.mapleader = config.mapleader

local opt = vim.opt

if config.proxy.github then
	util.proxyGithub = function(url) return config.proxy.github .. url end
else
	util.proxyGithub = function(url) return url end
end

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	return string.gsub(text, '\n', '')
end

vim.cmd [[
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
]]

opt.shell = vim.env.SHELL

-- 默认的状态栏显示的内容。vim-airline 会覆盖这个配置，当禁用 airline 时此行生效。
opt.statusline = '%F%m%r%h%w [FORMAT=%{&ff}] [TYPE=%Y] [POS=%l,%v][%p%%] %{strftime(\"%d/%m/%y - %H:%M\")}'

-- Set the default listing style:
-- = 0: thin listing (one file per line)
-- = 1: long listing (one file per line with time
--      stamp information and file size)
-- = 2: wide listing (multiple files in columns)
-- = 3: tree style listing
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30
vim.g.netrw_nogx = 1 -- disable netrw's gx mapping. I use open-browser.vim

-- set wrap -- turn on line wrapping
opt.textwidth = 0 -- Maximum width of text to wrap
-- opt.wrapmargin=0 " wrap lines when coming within n characters from side
-- opt.linebreak = true " set soft wrapping

opt.diffopt = opt.diffopt + { 'vertical' }
opt.compatible = false -- not compatible Vi. Default "nocompatible" in nvim.

opt.shortmess = 'ilmnrwxst'
opt.showmode = true
opt.hidden = false -- current buffer can be put into background"
opt.lazyredraw = true -- don't update the display while executing macros
opt.autoread = true -- detect when a file is changed
opt.whichwrap = 'b,s' -- 允许 backspace 和空格键跨越行边界
opt.backspace = { 'indent', 'eol', 'start' } -- 使 backspace 正常处理 indent, eol, start 等
opt.smartindent = true
opt.autoindent = true -- Indent at the same level of the previous line
opt.laststatus = 2 -- always show status line
opt.scrolloff = 0 -- 0:光标不固定；999:光标始终保持在屏幕中央

opt.report = 0 -- 通过使用: commands命令，告诉我们文件的哪一行被改变过
opt.showmatch = true -- show matching bracket (briefly jump)
opt.matchtime = 1 -- show matching bracket for 0.2 seconds
opt.formatoptions = opt.formatoptions + 'mB'
opt.conceallevel = 2
opt.concealcursor = ''
opt.sessionoptions = { 'buffers', 'curdir', 'resize', 'tabpages', 'winpos', 'winsize' }
opt.termguicolors = true -- Require true color
opt.background = 'dark'

opt.showcmd = true -- 显示当前正在输入的命令
opt.completeopt = { 'menu', 'preview' }
opt.list = false -- 不显示制表符

-- set ignore file extension of wildmenu, won't list when using filename completion
opt.wildignore = opt.wildignore + {
	'*.a', '*.o', '.DS_Store', '.git', '.hg', '.svn', '*~', '*.swp', '*.tmp', '*/.sass-cache/*', '*.scssc'
}
opt.wildmode = { 'list', 'full' } -- Command <Tab> completion, list matches, then longest common part, then all.

-- Edit
opt.tabstop = 4 -- Tab 键的宽度，tabstop 和 shiftwidth 需要一致。这里设定的是默认值
opt.shiftwidth = 4 -- 每一次缩进对应的空格数。这里设定的是默认值
opt.softtabstop = 4 -- 按一次退格键删掉的空格数。这里设定的是默认值
opt.shiftround = true -- 缩进取整，round indent to a multiple of 'shiftwidth'
opt.expandtab = true -- 使用空格代替制表符
opt.smarttab = true
opt.iskeyword = opt.iskeyword - { '.' }

opt.ruler = true -- 打开状态栏标尺
opt.confirm = true -- 在处理未保存或只读文件的时候，弹出确认
opt.ttimeout = true -- prevent '<esc>' delay in terminal http://stackoverflow.com/a/33957679/2326199
opt.timeoutlen = 99999 -- 一直等待组合键完成
opt.scrolljump = 1 -- Lines to scroll when cursor leaves screen

-- folding
opt.foldcolumn = '0' -- 不显示左侧折叠栏
-- manual    手工折叠
-- indent    使用缩进表示折叠
-- expr      使用表达式定义折叠
-- syntax    使用语法定义折叠
-- diff      对没有更改的文本进行折叠
-- marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
opt.foldmethod = 'indent'
opt.foldlevel = 99

-- mouse
opt.mouse = 'nvc'
opt.mousemodel = 'popup'
opt.selection = 'exclusive' -- 可以在任何地方使用鼠标点击

-- Searching
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- case-sensitive if expresson contains a capital letter
opt.inccommand = 'split' -- neovim feature: live preview

-- error bells
opt.errorbells = false
opt.visualbell = true


opt.history = config.history
opt.cmdheight = config.cmdheight
opt.cc = config.highlightColumn
opt.synmaxcol = config.synmaxcol
opt.updatetime = config.updatetime
opt.updatecount = config.updatecount
opt.foldenable = config.foldenable
opt.fillchars = config.fillchars
opt.listchars = config.listchars
opt.showbreak = config.linebreakChar
opt.langmenu = config.langmenu
opt.matchpairs = config.matchpairs
opt.guicursor = config.guicursor
opt.fileencodings = config.fileencodings
opt.fileformats = config.fileformats

opt.spell = config.spell.check
opt.spellfile = vim.fn.stdpath('config') .. 'nvim/spell/en.utf-8.add'
opt.spelllang = config.spell.lang
opt.spellsuggest = config.spell.suggest

if config.systemClipboard then
	opt.clipboard = opt.clipboard + { 'unnamed' }
end

if config.linenumber then
	opt.number = true -- show line number
	opt.relativenumber = true -- show relative line number
end
