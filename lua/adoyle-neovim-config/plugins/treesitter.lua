local config = require('adoyle-neovim-config.config').get_global()
local util = require('adoyle-neovim-config.util')

local M = {
	nil,
	disable = false,
	requires = {
		{
			'nvim-treesitter/nvim-treesitter',
			disable = false,
			-- run = ':TSUpdate',
		},

		{
			'nvim-treesitter/playground',
			desc = ':TSPlaygroundToggle and :TSHighlightCapturesUnderCursor',
		},
	}
}

function M.config()
	require('nvim-treesitter.configs').setup {
		-- A list of parser names, or "all"
		ensure_installed = config.treesitter.ensure_installed,

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- List of parsers to ignore installing (for "all")
		ignore_install = config.treesitter.ignore_install,

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
			-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
			-- the name of the parser)
			-- list of language that will be disabled
			disable = config.treesitter.highlight.disable,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	}

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

	-- Fix the luochen1990/rainbow not work
	require 'nvim-treesitter.highlight'
	local hlmap = vim.treesitter.highlighter.hl_map
	hlmap['punctuation.bracket'] = nil

	require "nvim-treesitter.configs".setup {
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
		}
	}
end

return M
