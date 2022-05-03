local M = {
	'navarasu/onedark.nvim',
	disable = false,
}

function MySetup()
	local cmd = vim.cmd
	-- highlight current line
	-- vim.api.nvim_create_autocmd({'WinLeave'}, { pattern = '*', command = 'set nocursorline' })
	cmd [[
		set nocursorcolumn
		set cursorline
		autocmd WinLeave,BufLeave * set nocursorline
		autocmd WinEnter,BufEnter * set cursorline
	]]
end

function SetupOnedark()
	local o = require('onedark')

	o.setup {
		-- Main options --
		style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		transparent = false, -- Show/hide background
		term_colors = true, -- Change terminal color as per the selected theme style
		ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
		cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
		-- toggle theme style ---
		toggle_style_key = '<leader>ts', -- Default keybinding to toggle
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
			black = '#101012',
			bg0 = '#101112',
			bg1 = '#18191B',
			bg2 = '#35363b',
			bg3 = '#37383d',
			bg_d = '#1b1c1e',
			bg_blue = '#7D8CA3',
			bg_yellow = '#F7B538',
			fg = '#CED3DC',
			purple = '#875FDF',
			-- green = '#AFD787',
			green = '#63D846',
			orange = '#D75F00',
			blue = '#87AFFF',
			yellow = '#E3D888',
			cyan = '#87DFDF',
			red = '#BF3100',
			grey = '#6C6F7F',
			light_grey = '#818387',
			dark_cyan = '#00AFAF',
			dark_red = '#800000',
			dark_yellow = '#84714F',
			dark_purple = '#2E294E',
			diff_add = '#63D846',
			diff_delete = '#C03221',
			diff_change = '#011627',
			diff_text = '#363537',
		}, -- Override default colors
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

function M.config()
	SetupOnedark()
	MySetup()
end

return M
