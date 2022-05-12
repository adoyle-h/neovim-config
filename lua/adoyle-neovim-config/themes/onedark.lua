local config = require('adoyle-neovim-config.config').get_global()

local M = {
	'navarasu/onedark.nvim',
	disable = false,
}

function M.config()
	local o = require('onedark')
	local color = config.color;

	o.setup {
		-- Main options --
		style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		transparent = false, -- Show/hide background
		term_colors = true, -- Change terminal color as per the selected theme style
		ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
		cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
		-- toggle theme style ---
		toggle_style_key = '<leader>tn', -- Default keybinding to toggle
		toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

		-- Change code style ---
		-- Options are italic, bold, underline, none
		-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
		code_style = {
			comments = 'italic',
			keywords = 'none',
			functions = 'none',
			strings = 'none',
			variables = 'none'
		},

		-- Custom Highlights --
		colors = {
			black = color.black,
			bg0 = color.black,
			bg1 = color.grey1,
			bg2 = color.grey2,
			bg3 = color.grey3,
			bg_d = color.bg_d,
			bg_blue = color.blueBG,
			bg_yellow = color.yellowBG,
			fg = color.white,
			green = color.green,
			orange = color.orange,
			blue = color.blue,
			cyan = color.cyan,
			purple = color.purple,
			yellow = color.yellow,
			red = color.red,
			grey = color.grey,
			light_grey = color.lightGrey,
			dark_cyan = color.darkCyan,
			dark_red = color.darkRed,
			dark_yellow = color.darkYellow,
			dark_purple = color.darkPurple,
			diff_add = color.diffAddBG,
			diff_delete = color.diffDeleteBG,
			diff_change = color.diffChangeBG,
			diff_text = color.diffText,
		},

		highlights = {}, -- Override highlight groups

		-- Plugins Config --
		diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		},
	}

	o.load()
end

return M
