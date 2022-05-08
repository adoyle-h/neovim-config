local M = {
	nil,
	desc = 'color settings',
	disable = false,
}

M.requires = {
	require('themes.' .. vim.config.theme),

	{
		'guns/xterm-color-table.vim',
		on = {'XtermColorTable', 'SXtermColorTable', 'VXtermColorTable', 'TXtermColorTable', 'EXtermColorTable', 'OXtermColorTable'},
		desc = '终端颜色表',
		disable = false,
	},

	require 'plugins.color-inline',
}

local color = vim.config.color

local function configGeneralHighlights()
	-- vim.cmd [[
	--   Inactive buffer will be grey color
	--   hi InactiveWindow ctermbg=234 guibg=#18191B
	--   set winhighlight=NormalNC:InactiveWindow

	--   hi Pmenu cterm=NONE ctermfg=251 ctermbg=235 guibg=Grey
	--   hi PmenuSel cterm=NONE ctermfg=232 ctermbg=246 guibg=DarkGrey
	--   hi PmenuSbar cterm=NONE ctermfg=234 ctermbg=234 guibg=Grey
	--   hi PmenuThumb cterm=NONE ctermfg=247 ctermbg=247 guibg=White
	-- ]]

	local hls = {
		-- Diagnostic Popup Window Background
		{'hi NormalFloat ctermbg=0 guibg=%s', color.black},
		-- Diagnostic Popup Window Border
		{'hi FloatBorder cterm=NONE ctermfg=8 ctermbg=0 guibg=%s guifg=%s', color.black, color.grey3},
	}

	for _, v in pairs(hls) do
		vim.cmd(vim.fn.printf(table.unpack(v)))
	end
end

local function configCursorLine()
	-- highlight current line
	vim.opt.cursorcolumn = false
	vim.opt.cursorline = true

	vim.api.nvim_create_autocmd(
		{ 'WinLeave', 'BufLeave' },
		{ pattern = '*', command = 'set nocursorline' }
	)

	vim.api.nvim_create_autocmd(
		{ 'WinEnter', 'BufEnter' },
		{ pattern = '*', command = 'set cursorline' }
	)

	-- Current neovim not support vin.api.nvim_set_hl. See Bug https://github.com/neovim/neovim/issues/18160
	-- vim.api.nvim_set_hl(0, 'CursorLine', {guibg = color.cursorLineBG})

	local hls = {
		{'hi CursorLine guibg=%s', color.cursorLineBG},
		{'hi CursorLineNr guibg=%s guifg=%s', color.cursorLineBG, color.cursorLineNrFG},
	}

	for _, v in pairs(hls) do
		vim.cmd(vim.fn.printf(table.unpack(v)))
	end
end


function M.config()
	configGeneralHighlights()
	configCursorLine()
end

return M
