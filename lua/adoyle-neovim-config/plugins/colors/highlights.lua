local M = { desc = 'Define highlight groups' }

local config = require('adoyle-neovim-config.config').config
local colors = config.colors
local set_hl = vim.api.nvim_set_hl

M.defaultConfig = {
	'highlights',
	{
		-- Or 'MyCursor' = function(colors) return { bg = colors.blue } end,
		MyCursor = { bg = colors.blue },
		Visual = { bg = colors.darkOrange, fg = colors.white },
		QuickFixLine = { bg = colors.darkYellow, bold = true },
		Whitespace = { fg = '#958720' },
		NonText = { fg = colors.grey, bg = 'NONE' },

		NormalFloat = { bg = colors.black }, -- Float Window
		FloatBorder = { bg = colors.black, fg = colors.blue }, -- Float Window Border
		MatchParen = { fg = colors.orange, bg = colors.black, underline = true },
		DiagnosticVirtualTextError = { fg = colors.red },
	},
}

function M.config()
	vim.api.nvim_create_autocmd({ 'VimEnter' }, {
		callback = function()
			for group, opts in pairs(config.highlights) do
				if type(opts) == 'function' then opts = opts(colors) end
				set_hl(0, group, opts)
			end
		end,
	})
end

return M
