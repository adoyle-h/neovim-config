local M = { 'navarasu/onedark.nvim' }

function M.config(config)
	local o = require('onedark')
	local colors = config.colors;

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
			variables = 'none',
		},

		-- Custom Highlights --
		colors = {
			black = colors.black,
			bg0 = colors.black,
			bg1 = colors.grey1,
			bg2 = colors.grey2,
			bg3 = colors.grey3,
			bg_d = colors.bg_d,
			bg_blue = colors.blueBG,
			bg_yellow = colors.yellowBG,
			fg = colors.white,
			green = colors.green,
			orange = colors.orange,
			blue = colors.blue,
			cyan = colors.cyan,
			purple = colors.purple,
			yellow = colors.yellow,
			red = colors.red,
			grey = colors.grey,
			light_grey = colors.lightGrey,
			dark_cyan = colors.darkCyan,
			dark_red = colors.darkRed,
			dark_yellow = colors.darkYellow,
			dark_purple = colors.darkPurple,
			diff_add = colors.diffAddBG,
			diff_delete = colors.diffDeleteBG,
			diff_change = colors.diffChangeBG,
			diff_text = colors.diffText,
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
