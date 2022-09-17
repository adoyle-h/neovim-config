local config = require('adoyle-neovim-config.config').config

local M = {
	'olimorris/onedarkpro.nvim',
	disable = false,
}

function M.config()
	local o = require('onedarkpro')
	local color = config.color;

	o.setup({
		dark_theme = 'onedark', -- The default dark theme

		colors = { -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
			bg = color.black,
			fg = color.white,
			red = color.red,
			orange = color.orange,
			yellow = color.yellow,
			green = color.green,
			cyan = color.cyan,
			blue = color.blue,
			purple = color.purple,
			white = color.white,
			black = color.black,
			gray = color.grey,
			highlight = color.yellow,

			cursorline = color.cursorLineBG,
			comment = color.grey,
			selection = color.selection,

			diff_add = color.diffAddBG,
			diff_delete = color.diffDeleteBG,
			diff_text = color.diffText,
			-- diff_change = color.diffChangeBG,
		},

		highlights = { -- Override default highlight groups
			TelescopeMatching = { fg = "${orange}" },
			Search = { style = 'none' },
			QuickFixLine = { bg = color.darkYellow, style = 'bold' }
		},

		ft_highlights = {}, -- Override default highlight groups for specific filetypes

		plugins = { -- Override which plugins highlight groups are loaded
			native_lsp = true,
			treesitter = false,
			telescope = true,
			-- All plugins list in https://github.com/olimorris/onedarkpro.nvim/tree/main/lua/onedarkpro/plugins
		},

		styles = {
			strings = "NONE", -- Style that is applied to strings
			comments = 'italic', -- Style that is applied to comments
			keywords = "NONE", -- Style that is applied to keywords
			functions = "NONE", -- Style that is applied to functions
			variables = "NONE", -- Style that is applied to variables
			virtual_text = "NONE", -- Style that is applied to virtual text
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
		}
	})

	o.load()
end

return M
