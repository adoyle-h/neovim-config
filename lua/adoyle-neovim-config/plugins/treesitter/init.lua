local M = {
	'treesitter',

	requires = {
		{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
		{ 'nvim-treesitter/playground', desc = ':TSPlaygroundToggle and :TSHighlightCapturesUnderCursor' },
		require('adoyle-neovim-config.plugins.treesitter.context'),
		require('adoyle-neovim-config.plugins.treesitter.rainbow'),
		require('adoyle-neovim-config.plugins.treesitter.pairs'),
	},

	highlights = require('adoyle-neovim-config.plugins.treesitter.highlights'),
}

M.defaultConfig = {
	'treesitter',
	{
		prefer_git = false,

		ensure_installed = {}, -- A list of parser names, or "all",
		auto_install = false,
		sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
		ignore_install = {}, -- List of parsers to ignore installing (for "all")

		highlight = {
			-- `false` will disable the whole extension
			enable = true, -- `false` will disable the whole extension

			-- list of language that will be disabled.
			-- NOTE: these are the names of the parsers and not the filetype.
			-- (for example if you want to disable highlighting for the `tex` filetype,
			-- you need to include `latex` in this list as this is the name of the parser)
			disable = {
				'markdown', -- Use my markdown highlights instead of
				'help', -- The help use tree-sitter-vimdoc as parser. But currently its highlights is poor than builtin.
			},

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = 'vn',
				node_incremental = 'vn',
				node_decremental = 'vN',
				scope_incremental = 'vm',
			},
		},

		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = 'o',
				toggle_hl_groups = 'i',
				toggle_injected_languages = 't',
				toggle_anonymous_nodes = 'a',
				toggle_language_display = 'I',
				focus_language = 'f',
				unfocus_language = 'F',
				update = 'R',
				goto_node = '<cr>',
				show_help = '?',
			},
		},
	},
}

function M.config(config)
	local util = require('adoyle-neovim-config.util')

	require('nvim-treesitter.install').prefer_git = config.treesitter.prefer_git

	if config.proxy.github then
		for _, treesitterConf in pairs(require('nvim-treesitter.parsers').get_parser_configs()) do
			treesitterConf.install_info.url = treesitterConf.install_info.url:gsub('https://github.com/',
				util.proxyGithub 'https://github.com/')
		end
	end

	vim.opt.foldmethod = 'expr'
	vim.cmd [[
		set foldexpr=nvim_treesitter#foldexpr()
	]]

	require('nvim-treesitter.configs').setup(config.treesitter)
end

return M