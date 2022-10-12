local M = { 'olimorris/onedarkpro.nvim' }

local config = require('adoyle-neovim-config.config').config
local colors = config.colors;

function M.config()
	require('onedarkpro').setup(config.onedarkpro)
	vim.cmd('colorscheme onedarkpro')
end

M.defaultConfig = {
	'onedarkpro',
	{
		dark_theme = 'onedark', -- The default dark theme
		caching = false, -- Use caching for the theme?

		colors = { -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
			bg = colors.black,
			fg = colors.white,
			red = colors.red,
			orange = colors.orange,
			yellow = colors.yellow,
			green = colors.green,
			cyan = colors.cyan,
			blue = colors.blue,
			purple = colors.purple,
			white = colors.white,
			black = colors.black,
			gray = colors.grey,
			highlight = colors.yellow,

			cursorline = colors.darkBlue,
			comment = colors.grey,
			selection = colors.selection,

			diff_add = colors.diffAddBG,
			diff_delete = colors.diffDeleteBG,
			diff_text = colors.diffText,
			-- diff_change = color.diffChangeBG,
		},

		highlights = { -- Override default highlight groups
			StatusLine = { bg = 'NONE', fg = 'NONE' }, -- Fix caret in statusline. https://github.com/nvim-lualine/lualine.nvim/discussions/866
		},

		-- https://github.com/olimorris/onedarkpro.nvim#configuring-filetypes
		filetypes = { all = false },

		plugins = { -- Override which plugins highlight groups are loaded
			-- All plugins list in https://github.com/olimorris/onedarkpro.nvim#electric_plug-supported-plugins
			all = false,
			native_lsp = true,
			nvim_notify = true,
			neo_tree = true,
			nvim_cmp = true,
			treesitter = true,
			-- nvim_ts_rainbow = true,
		},

		styles = {
			strings = 'NONE', -- Style that is applied to strings
			comments = 'italic', -- Style that is applied to comments
			keywords = 'NONE', -- Style that is applied to keywords
			functions = 'NONE', -- Style that is applied to functions
			variables = 'NONE', -- Style that is applied to variables
			virtual_text = 'NONE', -- Style that is applied to virtual text
		},

		options = {
			bold = true, -- Use the themes opinionated bold styles?
			italic = true, -- Use the themes opinionated italic styles?
			underline = true, -- Use the themes opinionated underline styles?
			undercurl = true, -- Use the themes opinionated undercurl styles?
			cursorline = true, -- Use cursorline highlighting?
			transparency = false, -- Use a transparent background?
			terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
			window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
		},
	},
}

return M
