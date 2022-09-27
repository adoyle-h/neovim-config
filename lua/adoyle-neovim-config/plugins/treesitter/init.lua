local config = require('adoyle-neovim-config.config').config
local color = config.color

local M = {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',
	requires = {
		require('adoyle-neovim-config.plugins.treesitter.context'),
		require('adoyle-neovim-config.plugins.treesitter.rainbow'),
		{ 'nvim-treesitter/playground', desc = ':TSPlaygroundToggle and :TSHighlightCapturesUnderCursor' },
	},
}

-- Use :TSCaptureUnderCursor to get highlight group of text
-- Color schema references:
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
M.highlights = {
	{ 'TSVariable', { fg = color.white } },
	{ 'TSParameter', { fg = color.white } },
	{ 'TSProperty', { fg = '#5098A3' } },
	{ 'TSKeyword', { fg = '#9ED817' } },
	{ 'TSFunction', { fg = '#3D84FF' } }, -- #4083F8
	{ 'TSKeywordFunction', { fg = '#1197DC' } },
	{ 'TSField', { fg = '#B1B16B' } },
	{ 'TSKeywordReturn', { fg = '#3C9B2F' } },
	{ 'TSConditional', { fg = '#916E99' } },
	{ 'TSType', { fg = '#C9853E' } },
	{ 'TSBoolean', { fg = '#AD3838' } },
	{ 'TSConstant', { fg = '#CBB708' } },
	{ 'TSInclude', { fg = '#A486E1' } },
	{ 'TSNamespace', { fg = '#8255FF' } },

	{ 'TreesitterContext', { bg = color.darkCyan, italic = true, bold = true } },
	{ 'TreesitterContextLineNumber', { bg = color.darkCyan, italic = true, bold = true } },
}

M.defaultConfig = {
	'treesitter',
	{
		ensure_installed = {}, -- A list of parser names, or "all",
		sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
		ignore_install = { 'rasi', 'r', 'd', 'v', 'slint' }, -- List of parsers to ignore installing (for "all")

		highlight = {
			-- `false` will disable the whole extension
			enable = true, -- `false` will disable the whole extension

			-- list of language that will be disabled.
			-- NOTE: these are the names of the parsers and not the filetype.
			-- (for example if you want to disable highlighting for the `tex` filetype,
			-- you need to include `latex` in this list as this is the name of the parser)
			disable = { 'markdown' },

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
	},
}

function M.config()
	local util = require('adoyle-neovim-config.util')

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

	require('nvim-treesitter.configs').setup(config.treesitter)
end

return M
