return function(color)
	-- The key naming of groups is meaningless. Just for config override accurately.
	return {
		basic = {
			-- function(c) return { 'MyCursor', { bg = color.blue } } end,
			{ 'MyCursor', { bg = color.blue } },
			{ 'CursorLine', { bg = color.cursorLineBG } },
			{ 'CursorLineNr', { bg = color.cursorLineBG, fg = color.cursorLineNrFG } },
		},

		nvimWindow = { -- lua/adoyle-neovim-config/plugins/move.lua
			{ 'NvimWindowFloating', { fg = color.blue, bg = color.black } },
		},

		diff = {
			{ 'DiffDelete', { fg = color.red, bg = color.darkRed } },
			{ 'DiffChange', { bg = color.darkYellow, nocombine = true } },
			{ 'DiffText', { bg = '#484800', nocombine = true } },
		},

		lspConfig = {
			{ 'LspWindowBorder', { fg = color.cyan } },
			{ 'DiagnosticBorder', { fg = color.cyan } },
			-- Diagnostic Popup Window Background
			{ 'NormalFloat', { bg = color.black } },
			-- Diagnostic Popup Window Border
			{ 'FloatBorder', { bg = color.black, fg = color.grey3 } },
			{ 'MatchParen', { fg = color.orange, bg = color.black, underline = true } },
			{ 'DiagnosticVirtualTextError', { fg = color.red } },
		},

		lspInfo = {
			{ 'LspInfoTitle', { fg = color.lightGreen } }, -- Client name
			{ 'LspInfoList', { fg = color.lightGreen } }, -- Server name list
			{ 'LspInfoFiletype', { fg = color.purple } }, -- `filetypes` area
			{ 'LspInfoTip', { link = 'Comment' } }, -- Tip
			{ 'LspInfoBorder', { fg = color.blue } }, -- Window border
		},

		neotree = {
			{ 'NeoTreeGitUntracked', { fg = color.green } },
			{ 'NeoTreeFileIcon', { fg = color.white } },
			{ 'NeoTreeGitUnstaged', { fg = color.yellow } },
		},
	}
end
