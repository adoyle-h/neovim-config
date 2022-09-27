local M = { nil, desc = 'Define highlight groups' }

local config = require('adoyle-neovim-config.config').config
local color = config.color

M.defaultConfig = {
	'highlights',
	{
		-- The key naming of groups is meaningless. Just for user config override more accurately.
		basic = {
			-- function(c) return { 'MyCursor', { bg = color.blue } } end,
			{ 'MyCursor', { bg = color.blue } },
			-- { 'CursorLine', { bg = color.darkBlue } },
			{ 'CursorLineNr', { bg = color.darkBlue, fg = color.blue } },
			{ 'Visual', { bg = color.darkOrange } },

		},

		diff = {
			{ 'DiffDelete', { fg = color.red, bg = color.darkRed } },
			{ 'DiffChange', { bg = color.darkYellow, nocombine = true } },
			{ 'DiffText', { bg = '#484800', nocombine = true } },
		},

		diagnostic = {
			-- Diagnostic Popup Window Background
			{ 'NormalFloat', { bg = color.black } },
			-- Diagnostic Popup Window Border
			{ 'FloatBorder', { bg = color.black, fg = color.grey3 } },
			{ 'MatchParen', { fg = color.orange, bg = color.black, underline = true } },
			{ 'DiagnosticVirtualTextError', { fg = color.red } },
		},
	},
}

function M.config()
	local set_hl = vim.api.nvim_set_hl

	for _, group in pairs(config.highlights) do
		for _, hl in pairs(group) do
			if type(hl) == 'function' then hl = hl(color) end
			set_hl(0, hl[1], hl[2])
		end
	end
end

return M
