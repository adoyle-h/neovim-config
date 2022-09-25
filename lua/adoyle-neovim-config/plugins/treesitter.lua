local config = require('adoyle-neovim-config.config').config
local util = require('adoyle-neovim-config.util')

local Rainbow = {
	'p00f/nvim-ts-rainbow',
	desc = 'Rainbow brackets',
	defaultConfig = {
		'tsRainbow',
		{
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			colors = { -- table of hex strings
				-- LuaFormatter off
				'#005f87', '#d75f00', '#12ff5f', '#0087ff', '#00aa87', '#b2ffaf', '#ff5f00',
				'#6F3080', '#ff00ff', '#8787ff', '#87875f',
				-- LuaFormatter on
			},

			termcolors = { -- table of colour name strings
			},
		},
	},
}

local M = {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',
	requires = {
		{ 'nvim-treesitter/playground', desc = ':TSPlaygroundToggle and :TSHighlightCapturesUnderCursor' },

		{
			'nvim-treesitter/nvim-treesitter-context',
			desc = 'shows the context of the currently visible buffer contents.',
			disable = not config.codeContext.float,
		},

		Rainbow,
	},

	highlights = function(color)
		util.set_hl(color.treesitter)

		return {
			{ 'TreesitterContext', { bg = color.contextBG, italic = true, bold = true } },
			{ 'TreesitterContextLineNumber', { bg = color.contextBG, italic = true, bold = true } },
		}
	end,
}

M.defaultConfig = {
	'treesitter',
	{
		ensure_installed = {}, -- A list of parser names, or "all"
		sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
		ignore_install = { 'rasi', 'r', 'd', 'v', 'slint' }, -- List of parsers to ignore installing (for "all")

		highlight = {
			enable = true, -- `false` will disable the whole extension

			-- list of language that will be disabled.
			-- NOTE: these are the names of the parsers and not the filetype.
			-- (for example if you want to disable highlighting for the `tex` filetype,
			-- you need to include `latex` in this list as this is the name of the parser)
			disable = { 'markdown' },
		},
	},
}

function M.config()
	local conf = config.treesitter

	require('nvim-treesitter.install').prefer_git = true
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

	require('nvim-treesitter.configs').setup {
		ensure_installed = conf.ensure_installed,
		sync_install = conf.sync_install,
		ignore_install = conf.ignore_install,

		highlight = {
			-- `false` will disable the whole extension
			enable = conf.highlight.enable,
			disable = conf.highlight.disable,

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
