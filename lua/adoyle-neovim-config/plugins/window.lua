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
	disable = true,
	desc = 'Resize window layout',
	config = function()
		vim.g.winresizer_vert_resize = 5
		vim.g.winresizer_horiz_resize = 3
		vim.g.winresizer_start_key = '<C-W><C-W>'
	end,
}

local M = { nil, disable = false, requires = { Shade, Maximize, Resize } }

return M
