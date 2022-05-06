local M = {
	'navarasu/onedark.nvim',
	-- 'marko-cerovac/material.nvim',
	disable = false,
}

local function configCursorLine()
	-- highlight current line
	vim.opt.cursorcolumn = false
	vim.opt.cursorline = true

	vim.api.nvim_create_autocmd(
		{ 'WinLeave', 'BufLeave' },
		{ pattern = '*', command = 'set nocursorline' }
	)

	vim.api.nvim_create_autocmd(
		{ 'WinEnter', 'BufEnter' },
		{ pattern = '*', command = 'set cursorline' }
	)
end

local function setupOnedark()
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
			bg2 = '#282B2D',
			bg3 = '#34373B',
			bg_d = '#1b1c1e',
			bg_blue = '#7D8CA3',
			bg_yellow = '#F7B538',
			fg = '#CED3DC',
			-- green = '#63D846',
			green = '#75C44E',
			orange = '#D75F00',
			blue = '#689AFD',
			cyan = '#9AC3DE',
			-- purple = '#574AB2',
			purple = '#765ADA',
			-- yellow = '#E3D888',
			yellow = '#C3B11A',
			red = '#BF3100',
			grey = '#6C6F7F',
			light_grey = '#818387',
			dark_cyan = '#33869A',
			dark_red = '#800000',
			dark_yellow = '#84714F',
			dark_purple = '#73628A',
			diff_add = '#75C44E',
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

local function setupMaterial()

	vim.g.material_style = 'darker'

	require('material').setup({
		contrast = {
			sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
			floating_windows = false, -- Enable contrast for floating windows
			line_numbers = true, -- Enable contrast background for line numbers
			sign_column = true, -- Enable contrast background for the sign column
			cursor_line = true, -- Enable darker background for the cursor line
			non_current_windows = true, -- Enable darker background for non-current windows
			popup_menu = false, -- Enable lighter background for the popup menu
		},

		italics = {
			comments = false, -- Enable italic comments
			keywords = false, -- Enable italic keywords
			functions = false, -- Enable italic functions
			strings = false, -- Enable italic strings
			variables = false -- Enable italic variables
		},

		contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
			"terminal", -- Darker terminal background
			"packer", -- Darker packer background
			"qf" -- Darker qf list background
		},

		high_visibility = {
			lighter = false, -- Enable higher contrast text for lighter style
			darker = false -- Enable higher contrast text for darker style
		},

		disable = {
			borders = false, -- Disable borders between verticaly split windows
			background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
			term_colors = false, -- Prevent the theme from setting terminal colors
			eob_lines = false -- Hide the end-of-buffer lines
		},

		lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

		async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

		custom_highlights = {}, -- Overwrite highlights with your own
	})

	-- colorscheme must put after require('material').setup
	vim.cmd 'colorscheme material'
end

function M.config()
	setupOnedark()
	-- setupMaterial()
	configCursorLine()
end

return M
