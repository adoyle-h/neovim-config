return function(color)
	return {
		-- function(c) return { 'MyCursor', { bg = color.blue } } end,
		{ 'MyCursor', { bg = color.blue } },

		{ 'DiffDelete', { fg = color.red, bg = color.darkRed } },
		{ 'DiffChange', { bg = color.darkYellow, nocombine = true } },
		{ 'DiffText', { bg = '#484800', nocombine = true } },

		{ 'LspWindowBorder', { fg = color.cyan } },
		{ 'DiagnosticBorder', { fg = color.cyan } },
		-- Diagnostic Popup Window Background
		{ 'NormalFloat', { bg = color.black } },
		-- Diagnostic Popup Window Border
		{ 'FloatBorder', { bg = color.black, fg = color.grey3 } },
		{ 'MatchParen', { fg = color.orange, bg = color.black, underline = true } },
		{ 'DiagnosticVirtualTextError', { fg = color.red } },

		{ 'LspInfoTitle', { fg = color.lightGreen } }, -- Client name
		{ 'LspInfoList', { fg = color.lightGreen } }, -- Server name list
		{ 'LspInfoFiletype', { fg = color.purple } }, -- `filetypes` area
		{ 'LspInfoTip', { link = 'Comment' } }, -- Tip
		{ 'LspInfoBorder', { fg = color.blue } }, -- Window border
	}
end
