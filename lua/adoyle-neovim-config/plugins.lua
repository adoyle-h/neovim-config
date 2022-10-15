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

--------------------------------------

-- UI
Load 'plugins.colors'
Load 'plugins.statusline.lualine'
Load 'plugins.bufferline'
Load 'plugins.indent-line'
Load 'plugins.search'
Load 'plugins.scrollbar' -- scrollbar must put after search, it relies on nvim-hlslens
Load 'plugins.scroll'

-- Functions
Load 'plugins.keymap'
Load 'plugins.filetype'
Load 'plugins.lsp'
Load 'plugins.dap'
Load 'plugins.completion'
Load 'plugins.general'

Load 'plugins.bookmark'
Load 'plugins.mark'
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
Load 'plugins.profiling'
Load 'plugins.session'
Load 'plugins.select'
Load 'plugins.table'
Load 'plugins.todo'
Load 'plugins.trailing'
Load 'plugins.undotree'
Load 'plugins.window'
Load 'plugins.funny'
Load 'plugins.abbreviation'
Load 'plugins.terminal'
Load 'plugins.dashboard' -- Put this plugin after filetree and session plugin
Load 'plugins.winbar'
Load 'plugins.zen'
Load 'plugins.curl'
Load 'plugins.escape'
Load 'plugins.match'
Load 'plugins.test'
Load 'plugins.yank'
Load 'plugins.node'

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

Plug 'chrisbra/vim-diff-enhanced'
Plug { 'adoyle-h/vim-eunuch', branch = 'adoyle', desc = 'UNIX commands. See :h eunuch' }
Plug { 'tpope/vim-repeat', desc = 'Enable repeating other supported plugins with the . command' }
Plug { 'sotte/presenting.vim', ['for'] = 'markdown', desc = 'markdown presentation' }
Plug { 'mechatroner/rainbow_csv', desc = 'For .csv file' }

Plug 'ryanoasis/vim-devicons' -- Devicons for old vimscript plugins. It should be put at last!!
