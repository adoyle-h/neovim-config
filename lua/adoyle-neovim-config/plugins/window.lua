local config = require('adoyle-neovim-config.config').config

-- TO FIX:  Neovim not rendering the correct color when an underline is overlayed by a transparent floating window.
-- https://github.com/sunjon/Shade.nvim/issues/12
-- https://github.com/neovim/neovim/issues/14453
local Shade = {
	'sunjon/shade.nvim',
	desc = 'Dim inactive windows',
	disable = false,
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
	disable = false,
	config = function()
		require('windows').setup(config.window.maximize)
	end,
	keymaps = { { 'n', '<C-w>z', ':WindowsMaximize<CR>', { silent = true } } },
}

local Resize = {
	'simeji/winresizer',
	disable = false,
	desc = 'Resize window layout',
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
