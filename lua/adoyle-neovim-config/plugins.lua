-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide

local P = require('adoyle-neovim-config.vim-plug')
local util = require('adoyle-neovim-config.util')
local config = require('adoyle-neovim-config.config').global
local Plug = P.Plug

-- @type {function(path)} Load builtin plugin by filepath which relative lua directory.
local Load = function(path)
	local opts = require('adoyle-neovim-config.' .. path)
	local userPluginOpts = config.pluginOpts[path]
	opts = util.merge(opts, userPluginOpts)
	Plug(opts)
end

-- Library
-- Many plugins require plenary.nvim
Plug { 'nvim-lua/plenary.nvim', config = function()
	vim.api.nvim_create_user_command('PlenaryTest', ':lua require(\'plenary.test_harness\').test_directory(vim.fn.expand("%:p"))<CR>', {})
end }
Load 'plugins.notify'
-- Plug 'kyazdani42/nvim-web-devicons' -- Not suitable for now

-- UI
Load 'plugins.colors'
Load 'plugins.statusline'
Load 'plugins.dashboard'
Load 'plugins.brackets'
Load 'plugins.indent'
Load 'plugins.indent-line'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search, it relies on nvim-hlslens

-- Functions
Load 'plugins.keymap'
Load 'plugins.filetype'
Load 'plugins.treesitter'
Load 'plugins.lsp'
Load 'plugins.completion'

Load 'plugins.bookmark'
Load 'plugins.comment'
Load 'plugins.outline'
Load 'plugins.file-tree'
Load 'plugins.format'
Load 'plugins.git'
Load 'plugins.highlight-words'
Load 'plugins.increment'
Load 'plugins.markdown'
Load 'plugins.move'
Load 'plugins.open-url'
Load 'plugins.profiling'
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
Plug 'tpope/vim-repeat' -- enables repeating other supported plugins with the . command
Plug { 'sotte/presenting.vim', ['for'] = 'markdown', desc = 'markdown 幻灯片' }
Plug 'mechatroner/rainbow_csv' -- for .csv file

Plug {
	'rainbowhxch/accelerated-jk.nvim',
	disable = false,
	desc = 'j/k 移动自动加速',

	config = function()
		require('accelerated-jk').setup({
			mode = 'time_driven',
			enable_deceleration = false,
			acceleration_limit = 200,
			acceleration_table = { 5, 10, 12, 15, 18 },
		})
		vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
		vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
	end
}

Plug 'ryanoasis/vim-devicons' -- devicons should be put at last!!
