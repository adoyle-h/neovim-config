local config = require('adoyle-neovim-config.config').config
local util = require('adoyle-neovim-config.util')

local M = {
	'nvim-treesitter/nvim-treesitter',
	disable = false,
	run = ':TSUpdate',
	requires = {
		{
			'nvim-treesitter/playground',
			desc = ':TSPlaygroundToggle and :TSHighlightCapturesUnderCursor',
		},

		{
			'nvim-treesitter/nvim-treesitter-context',
			desc = 'shows the context of the currently visible buffer contents.',
			disable = not config.codeContext.float,
		},

		{
			'p00f/nvim-ts-rainbow',
			desc = 'Rainbow brackets',
		},
	}
}


local function configHighlights()
	local color = require('adoyle-neovim-config.config').config.color

	util.set_hl(color.treesitter)

	util.set_hl {
		{ 'TreesitterContext', { bg = color.contextBG, italic = true, bold = true } },
		{ 'TreesitterContextLineNumber', { bg = color.contextBG, italic = true, bold = true } },
	}
end

function M.config()
	configHighlights()

	local c = config.treesitter

	require("nvim-treesitter.install").prefer_git = true
	if config.proxy.github then
		for _, treesitterConf in pairs(require('nvim-treesitter.parsers').get_parser_configs()) do
			treesitterConf.install_info.url = treesitterConf.install_info.url:gsub(
				'https://github.com/',
				util.proxyGithub 'https://github.com/'
			)
		end
	end

	vim.opt.foldmethod = 'expr'
	vim.cmd [[
		set foldexpr=nvim_treesitter#foldexpr()
	]]

	require('nvim-treesitter.configs').setup {
		ensure_installed = c.ensure_installed,
		sync_install = c.sync_install,
		ignore_install = c.ignore_install,

		highlight = {
			-- `false` will disable the whole extension
			enable = c.highlight.enable,
			disable = c.highlight.disable,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
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

		rainbow = config.tsRainbow,
	}


	-- doc: https://github.com/nvim-treesitter/nvim-treesitter-context
	local has_ts_context, ts_context = pcall(require, 'treesitter-context')
	if has_ts_context then
		ts_context.setup {
			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		}
	end
end

return M
