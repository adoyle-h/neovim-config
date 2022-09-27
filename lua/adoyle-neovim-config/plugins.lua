-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide
local P = require('adoyle-neovim-config.vim-plug')
local util = require('adoyle-neovim-config.util')
local CM = require('adoyle-neovim-config.config')
local Plug = P.Plug

-- @type {function(path)} Load builtin plugin by filepath which relative lua directory.
local Load = function(path)
	local opts = require('adoyle-neovim-config.' .. path)
	local userPluginOpts = CM.pluginOpts[path]
	opts = util.merge(opts, userPluginOpts)
	Plug(opts)
end

------- Basic required plugins -------
Load 'plugins.vim-options'
Load 'plugins.plenary'
Load 'plugins.devicons' -- Devicons for nvim plugins
Plug 'MunifTanjim/nui.nvim'
Load 'plugins.notify'
Load 'plugins.notifier'

--------------------------------------

-- UI
Load 'plugins.colors'
Load 'plugins.statusline.lualine'
Load 'plugins.bufferline'
Load 'plugins.brackets'
Load 'plugins.indent-line'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search, it relies on nvim-hlslens

-- Functions
Load 'plugins.autocmd'
Load 'plugins.keymap'
Load 'plugins.filetype'
Load 'plugins.treesitter'
Load 'plugins.lsp'
Load 'plugins.dap'
Load 'plugins.completion'
Load 'plugins.general'

Load 'plugins.bookmark'
Load 'plugins.comment'
Load 'plugins.outline.aerial'
Load 'plugins.filetree.neo-tree'
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
Load 'plugins.window'
Load 'plugins.funny'
Load 'plugins.abbreviation'
Load 'plugins.terminal'
Load 'plugins.dashboard' -- Put this plugin after filetree plugin
Load 'plugins.winbar'
Load 'plugins.zen'

Plug 'chrisbra/vim-diff-enhanced'
Plug { 'adoyle-h/vim-eunuch', branch = 'adoyle', desc = 'UNIX commands. See :h eunuch' }

Plug {
	'chrisbra/Recover.vim',
	desc = 'Show difference between the hidden swap file and the regular saved file. Very useful.',
}

Plug {
	'tyru/capture.vim',
	on = 'Capture',
	desc = [[
		":Capture <Ex-Command>" to pipe Ex command output to new buffer'.
	  ":Capture mes" print messages.
	  ":Capture echo globpath(&rtp, 'doc/*.txt')".
	]],
}

-- This plugin was built while :w !sudo tee % > /dev/null trick does not work on neovim.
-- https://github.com/neovim/neovim/issues/1716
Plug 'lambdalisue/suda.vim'
Plug { 'tpope/vim-repeat', desc = 'Enable repeating other supported plugins with the . command' }
Plug { 'sotte/presenting.vim', ['for'] = 'markdown', desc = 'markdown presentation' }
Plug { 'mechatroner/rainbow_csv', desc = 'For .csv file' }

Plug 'ryanoasis/vim-devicons' -- Devicons for old vimscript plugins. It should be put at last!!
