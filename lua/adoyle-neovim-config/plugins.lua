local config = require('adoyle-neovim-config.config').config
local P = require('adoyle-neovim-config.vim-plug')
local Plug = P.Plug
local Load = P.LoadPluginFile

------- Basic required plugins -------
Load 'plugins.vim-options'
Load 'plugins.plenary'
Load 'plugins.devicons' -- Devicons for nvim plugins
Load 'plugins.notify'
Load 'plugins.notifier'
Load 'plugins.treesitter'
Plug 'MunifTanjim/nui.nvim'
Load 'plugins.telescope'

------------- UI plugins -------------
Load 'plugins.dressing'
Load('plugins.themes.' .. config.theme.use)
Load 'plugins.colors'
Load 'plugins.statusline.lualine'
Load 'plugins.bufferline'
Load 'plugins.indent-line'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search, it relies on nvim-hlslens
Load 'plugins.scroll'

---------- Enhanced plugins ----------
Load 'plugins.filetype'
Load 'plugins.lsp'
Load 'plugins.dap'
Load 'plugins.completion'
Load 'plugins.general'
Load 'plugins.comment'
Load 'plugins.outline.aerial'
Load 'plugins.format'
Load 'plugins.git'
Load 'plugins.highlight-words'
Load 'plugins.increment'
Load 'plugins.markdown'
Load 'plugins.move'
Load 'plugins.filetree.neo-tree' -- neo-tree must put after move plugin
Load 'plugins.open-url'
Load 'plugins.session'
Load 'plugins.select'
Load 'plugins.table'
Load 'plugins.trailing'
Load 'plugins.undotree'
Load 'plugins.window'
Load 'plugins.abbreviation'
Load 'plugins.terminal'
Load 'plugins.dashboard' -- Put this plugin after filetree and session plugin
Load 'plugins.escape'
Load 'plugins.match'
Load 'plugins.test'
Load 'plugins.yank'
Load 'plugins.trouble'
Load 'plugins.icon-picker'
Load 'plugins.diff'

Plug {
	'tyru/capture.vim',
	on = 'Capture',
	desc = [[
		":Capture <Ex-Command>" to pipe Ex command output to new buffer'.
	  ":Capture mes" print messages.
	  ":Capture echo globpath(&rtp, 'doc/*.txt')".
	]],
}

Plug {
	'lambdalisue/suda.vim',
	desc = 'read or write files with sudo command. :SudaRead and :SudaWrite',
}

Plug { 'adoyle-h/vim-eunuch', branch = 'adoyle', desc = 'UNIX commands. See :h eunuch' }
Plug { 'tpope/vim-repeat', desc = 'Enable repeating other supported plugins with the . command' }
Plug { 'mechatroner/rainbow_csv', desc = 'For .csv file', ['for'] = 'csv' }
Plug 'rohanorton/lua-gf.nvim'

------ Default disabled plugins ------
-- User can enable them on demand
Load 'plugins.profiling'
Load 'plugins.zk'
Load 'plugins.node'
Load 'plugins.curl'
Load 'plugins.funny'
Load 'plugins.latex'
Load 'plugins.calendar'
Load 'plugins.todo'
Load 'plugins.zen'
Load 'plugins.mark'
Load 'plugins.bookmark'
--------------------------------------

Plug 'ryanoasis/vim-devicons' -- Devicons for old vimscript plugins. It should be put at last!!
