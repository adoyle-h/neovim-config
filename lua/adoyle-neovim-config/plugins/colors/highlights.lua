local M = { nil, desc = 'Define highlight groups' }

local config = require('adoyle-neovim-config.config').config
local colors = config.colors

M.defaultConfig = {
	'highlights',
	{
		-- Or 'MyCursor' = function(colors) return { bg = colors.blue } end,
		MyCursor = { bg = colors.blue },
		Visual = { bg = colors.darkOrange },
		CursorLineNr = { bg = colors.darkBlue, fg = colors.blue, bold = true },
		QuickFixLine = { bg = colors.darkYellow, bold = true },

		-- If highlights not work, you may set highlights in lua/adoyle-neovim-config/themes/onedarkpro.lua

		DiffDelete = { fg = colors.red, bg = colors.darkRed },
		DiffChange = { bg = colors.darkYellow, nocombine = true },
		DiffText = { bg = '#484800', nocombine = true },

		-- Diagnostic Popup Window Background
		NormalFloat = { bg = colors.black },
		-- Diagnostic Popup Window Border
		FloatBorder = { bg = colors.black, fg = colors.grey3 },
		MatchParen = { fg = colors.orange, bg = colors.black, underline = true },
		DiagnosticVirtualTextError = { fg = colors.red },
	},
}

function M.config()
	vim.api.nvim_create_autocmd({ 'VimEnter' }, {
		callback = function()
			local set_hl = vim.api.nvim_set_hl

			for group, opts in pairs(config.highlights) do
				if type(opts) == 'function' then opts = opts(colors) end
				set_hl(0, group, opts)
			end
		end,
	})
end

return M
