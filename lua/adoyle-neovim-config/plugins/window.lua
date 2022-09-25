local config = require('adoyle-neovim-config.config').config

-- TO FIX:  Neovim not rendering the correct color when an underline is overlayed by a transparent floating window.
-- https://github.com/sunjon/Shade.nvim/issues/12
-- https://github.com/neovim/neovim/issues/14453
local Shade = {
	'sunjon/shade.nvim',
	desc = 'Dim inactive windows',

	defaultConfig = {
		{ 'window', 'shade' },
		{
			overlay_opacity = 40,
			opacity_step = 1,
			keys = { --
				brightness_up = '<C-Up>',
				brightness_down = '<C-Down>',
				toggle = '<Leader>sd',
			},
		},
	},

	config = function()
		local shade = require('shade')
		shade.setup(config.window.shade)
		shade.toggle()
	end,
}

local Maximize = {
	'anuvyklack/windows.nvim',
	requires = { 'anuvyklack/middleclass', 'anuvyklack/animation.nvim' },
	desc = 'Auto scale width of window. And maximize window',

	defaultConfig = {
		{ 'window', 'maximize' }, --
		{ -- :h windows.nvim
			autowidth = {
				-- BUG: When open telescope window in maximize window, nvim will throw error
				-- BUG: Aerial window will be autowidthed even when it is in ignore list
				enable = false,

				-- 0 < n < 1  The value between 0 to 1 will be considered as the fraction of the totall Vim window width.

				-- 1 < n < 2  Values between 1 and 2 will be considered as the fraction of the 'textwidth'.
				-- For example: `winwidth = 1.3` set split width to `1.3 * &textwidth`

				-- integer number (…, -2, -1, 0, 1, 2, …)
				--   The number of columns that will be added to 'textwidth'. If 'textwidth' is 0, assumed to 80.
				--   For example: `winwidth = 5` set split width to `&textwidth + 5`
				winwidth = 20, -- set split width to `&textwidth + 10`

				filetype = { -- Allow to set windows.winwidth per 'filetype' specific.
					help = 2,
				},
			},

			ignore = { --
				buftype = { 'quickfix' },
				filetype = { 'neo-tree', 'aerial', 'undotree', 'NvimTree' },
			},

			animation = { --
				enable = true,
				duration = 150,
				fps = 60,
				easing = 'in_out_sine',
			},
		},
	},

	config = function()
		require('windows').setup(config.window.maximize)
	end,

	keymaps = { { 'n', '<C-w>z', ':WindowsMaximize<CR>', { silent = true } } },
}

local Resize = {
	'simeji/winresizer',
	desc = 'Resize window layout',
	defaultConfig = {
		{ 'window', 'resize' }, --
		{ vert = 5, horiz = 3, trigger = '<C-W><C-W>' },
	},
	config = function()
		local c = config.window.resize
		vim.g.winresizer_gui_enable = 1
		vim.g.winresizer_vert_resize = c.vert
		vim.g.winresizer_horiz_resize = c.horiz
		vim.g.winresizer_start_key = c.trigger
	end,
}

local M = { nil, disable = false, requires = { Shade, Maximize, Resize } }

return M
