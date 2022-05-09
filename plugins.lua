-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local P = require('plugins.vim-plug')
local Plug = P.Plug
local Load = P.Load

P.start()

-- Library
Plug 'nvim-lua/plenary.nvim' -- Many plugins require plenary.nvim
Load 'plugins.notify'

-- UI
Load 'plugins.colors'
Load 'plugins.statusline'
Load 'plugins.dashboard'
Load 'plugins.brackets'
Load 'plugins.indent'
Load 'plugins.indent-line'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search, it relies on nvim-hlslens
Plug { 'psliwka/vim-smoothie', disable = true }

-- Functions
Load 'plugins.filetype'
Load 'plugins.treesitter'
Load 'plugins.lsp'
Load 'plugins.completion'

Load 'plugins.bookmark'
Load 'plugins.comment'
Load 'plugins.content-explorer'
Load 'plugins.file-explorer'
Load 'plugins.format'
Load 'plugins.git'
Load 'plugins.highlight-words'
Load 'plugins.increment'
Load 'plugins.markdown'
Load 'plugins.move'
Load 'plugins.open-url'
Load 'plugins.profile'
Load 'plugins.session'
Load 'plugins.select'
Load 'plugins.table'
Load 'plugins.telescope'
Load 'plugins.todo'
Load 'plugins.trailing'
Load 'plugins.undotree'
Load 'plugins.window-resize'
Load 'plugins.funny'
Load 'plugins.cheat'
Load 'plugins.writing'
Load 'plugins.keymap'
Load 'plugins.abbreviation'
Load 'plugins.autocmd'
Load 'plugins.utils'


Plug 'chrisbra/vim-diff-enhanced'
Plug { 'adoyle-h/vim-eunuch', branch = 'adoyle' } -- UNIX 命令封装。 :h eunuch
Plug 'chrisbra/Recover.vim' -- 崩溃后打开 swap 文件 diff
Plug { 'tyru/capture.vim', on = 'Capture' } -- :Capture <命令> 将结果输出到新的 buffer 中
Plug { 'neomutt/neomutt.vim', disbale = true, desc = 'neomutt' }
-- This plugin was built while :w !sudo tee % > /dev/null trick does not work on neovim. https://github.com/neovim/neovim/issues/1716
Plug 'lambdalisue/suda.vim'
Plug {
	'kassio/neoterm',
	desc = 'vim 内启动 shell',
	on = { 'T', 'Tnew', 'Tmap', 'Tpos', 'TTestSetTerm', 'TTestLib', 'TTestClearStatus', 'TREPLSetTerm', 'TREPLSendFile', 'TREPLSendLine', 'TREPLSendSelection', 'Topen', 'Ttoggle' },
}
Plug 'AndrewRadev/splitjoin.vim' -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'tpope/vim-repeat' -- enables repeating other supported plugins with the . command
Plug { 'sotte/presenting.vim', ['for'] = 'markdown', desc = 'markdown 幻灯片' }
Plug 'mechatroner/rainbow_csv' -- for .csv file


Plug 'ryanoasis/vim-devicons' -- devicons should be put at last!!
P.fin()
