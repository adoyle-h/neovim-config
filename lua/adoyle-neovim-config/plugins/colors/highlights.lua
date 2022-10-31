local M = { desc = 'Define highlight groups' }

local config = require('adoyle-neovim-config.config').config
local c = config.colors
local set_hl = vim.api.nvim_set_hl

M.defaultConfig = {
	'highlights',
	{
		-- Or 'MyCursor' = function(colors) return { bg = colors.blue } end,
		MyCursor = { bg = c.blue },
		Visual = { bg = c.darkOrange, fg = c.white },
		QuickFixLine = { bg = c.darkYellow, bold = true },
		Whitespace = { fg = '#958720' },
		NonText = { fg = c.grey3, bg = 'NONE' },
		Title = { fg = c.blue },

		NormalFloat = { bg = c.black }, -- Float Window
		FloatBorder = { bg = c.black, fg = c.blue }, -- Float Window Border
		MatchParen = { fg = c.match.fg, bg = c.black, underline = true },
		DiagnosticVirtualTextError = { fg = c.red },
	},
}

function M.config()
	vim.api.nvim_create_autocmd({ 'VimEnter' }, {
		callback = function()
			for group, opts in pairs(config.highlights) do
				if type(opts) == 'function' then opts = opts(c) end
				set_hl(0, group, opts)
			end
		end,
	})
end

return M
