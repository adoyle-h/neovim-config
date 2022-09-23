return {

	shade = {
		overlay_opacity = 40,
		opacity_step = 1,
		keys = { brightness_up = '<C-Up>', brightness_down = '<C-Down>', toggle = '<Leader>sd' },
	},

	resize = { vert = 5, horiz = 3, trigger = '<C-W><C-W>' },

	maximize = { -- :h windows.nvim
		autowidth = { --
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
			filetype = { 'neo-tree', 'aerial', 'undotree', 'NvimTree' }, -- @TODO aerial not ignore
		},

		animation = { --
			enable = true,
			duration = 150,
			fps = 60,
			easing = 'in_out_sine',
		},
	},

}
