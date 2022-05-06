-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local P = require('plugins.vim-plug')
local Plug = P.Plug
local Load = P.Load

P.start()

-- Library
Plug 'nvim-lua/plenary.nvim' -- Many plugin require plenary.nvim
Plug 'rcarriga/nvim-notify' -- super cool!

-- UI
Load 'plugins.colors'
Load 'plugins.statusline'
Load 'plugins.brackets'
Load 'plugins.indent'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search
Plug {'psliwka/vim-smoothie', disable = true}

-- Functions
Load 'plugins.treesitter'
Load 'plugins.lsp'
Load 'plugins.completion'

Load 'plugins.bookmark'
Load 'plugins.comment'
Load 'plugins.content-explorer'
Load 'plugins.file-explorer'
Load 'plugins.filetype'
Load 'plugins.format'
Load 'plugins.git'
Load 'plugins.highlight-words'
Load 'plugins.increment'
Load 'plugins.markdown'
Load 'plugins.move'
Load 'plugins.open-url'
Load 'plugins.profile'
Load 'plugins.session'
Load 'plugins.table'
Load 'plugins.telescope'
Load 'plugins.todo'
Load 'plugins.trailing'
Load 'plugins.undotree'
Load 'plugins.window-resize'
Load 'plugins.funny'
Load 'plugins.cheat'
Load 'plugins.writing'


Plug 'chrisbra/vim-diff-enhanced'
Plug {'adoyle-h/vim-eunuch', branch = 'adoyle'}  -- UNIX 命令封装。 :h eunuch
Plug 'chrisbra/Recover.vim'   -- 崩溃后打开 swap 文件 diff
Plug {'tyru/capture.vim', on = 'Capture'}  -- :Capture <命令> 将结果输出到新的 buffer 中
Plug 'neomutt/neomutt.vim'
-- This plugin was built while :w !sudo tee % > /dev/null trick does not work on neovim. https://github.com/neovim/neovim/issues/1716
Plug 'lambdalisue/suda.vim'
-- Plug {'kassio/neoterm', on = {'T', 'Tnew', 'Tmap', 'Tpos', 'TTestSetTerm', 'TTestLib', 'TTestClearStatus', 'TREPLSetTerm', 'TREPLSendFile', 'TREPLSendLine', 'TREPLSendSelection', 'Topen', 'Ttoggle'}}  -- vim 内启动 shell
Plug 'mg979/vim-visual-multi' -- 多光标选择
Plug 'AndrewRadev/splitjoin.vim' -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'tpope/vim-repeat' -- enables repeating other supported plugins with the . command
Plug {'sotte/presenting.vim',  ['for'] = 'markdown', desc = 'markdown 幻灯片' }
Plug 'mechatroner/rainbow_csv' -- for .csv file


Plug 'ryanoasis/vim-devicons' -- devicons should be put at last!!
P.fin()
