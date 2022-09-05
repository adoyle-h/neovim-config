local M = {
	'nvim-lualine/lualine.nvim',
	desc = 'lualine.nvim',
	disable = false,
	requires = {
	},
}

local printf = vim.fn.printf
local colors = require('adoyle-neovim-config.config').global.color.statusline
local sec_c_bg = colors.sec_c_bg

local function theme()
	return {
		normal = {
			a = { fg = colors.black, bg = colors.green, gui = 'bold' },
			b = { fg = colors.white, bg = colors.grey },
			c = { fg = colors.sec_c_fg, bg = sec_c_bg },
			y = { fg = colors.white, bg = colors.sec_y_bg },
			z = { fg = colors.black, bg = colors.green },
		},

		insert = {
			a = { fg = colors.black, bg = colors.blue, gui = 'bold' },
		},

		visual = {
			a = { fg = colors.black, bg = colors.orange, gui = 'bold' },
		},

		replace = {
			a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
		},

		inactive = {
			c = { fg = colors.white, bg = colors.black },
			a = { fg = colors.white, bg = colors.grey, gui = 'bold' },
			b = { fg = colors.white, bg = colors.sec_y_bg },
		},
	}
end

local modeMap = {
	['n']     = 'N', -- 'NORMAL'
	['no']    = 'O-PENDING',
	['nov']   = 'O-PENDING',
	['noV']   = 'O-PENDING',
	['no\22'] = 'O-PENDING',
	['niI']   = 'NORMAL',
	['niR']   = 'NORMAL',
	['niV']   = 'NORMAL',
	['nt']    = 'NORMAL',
	['ntT']   = 'NORMAL',
	['v']     = 'V', -- 'VISUAL'
	['vs']    = 'VISUAL',
	['V']     = 'V-LINE',
	['Vs']    = 'V-LINE',
	['\22']   = 'V-BLOCK',
	['\22s']  = 'V-BLOCK',
	['^V']    = 'V-BLOCK',
	['multi'] = 'Multi',
	['s']     = 'SELECT',
	['S']     = 'S-LINE',
	['\19']   = 'S-BLOCK',
	['i']     = 'I', -- 'INSERT',
	['ic']    = 'INSERT',
	['ix']    = 'INSERT',
	['R']     = 'R', -- 'REPLACE'
	['Rc']    = 'REPLACE',
	['Rx']    = 'REPLACE',
	['Rv']    = 'V-REPLACE',
	['Rvc']   = 'V-REPLACE',
	['Rvx']   = 'V-REPLACE',
	['c']     = 'COMMAND',
	['cv']    = 'EX',
	['ce']    = 'EX',
	['r']     = 'REPLACE',
	['rm']    = 'MORE',
	['r?']    = 'CONFIRM',
	['!']     = 'SHELL',
	['t']     = 'TERMINAL',
}


local function getMode()
	---@return string current mode name
	local mode_code = vim.api.nvim_get_mode().mode
	if modeMap[mode_code] == nil then
		return mode_code
	end
	return modeMap[mode_code]
end

local function mixLine()
	local space_pat = [[\v^ +]]
	local tab_pat = [[\v^\t+]]
	local space_indent = vim.fn.search(space_pat, 'nwc')
	local tab_indent = vim.fn.search(tab_pat, 'nwc')
	local mixed = (space_indent > 0 and tab_indent > 0)
	local mixed_same_line
	if not mixed then
		mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
		mixed = mixed_same_line > 0
	end
	if not mixed then return '' end
	if mixed_same_line ~= nil and mixed_same_line > 0 then
		return 'MIX:' .. mixed_same_line
	end
	local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
	local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
	if space_indent_cnt > tab_indent_cnt then
		return 'MIX:' .. tab_indent
	else
		return 'MIX:' .. space_indent
	end
end

local function paste()
	if vim.o.paste then
		return 'Ƥ'
	else
		return ''
	end
end

local function location()
	local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	local total = vim.api.nvim_buf_line_count(0)

	return printf('%s/%s %s', row, total, col)
end

local function spaces()
	return printf('ts:%s sw:%s', vim.o.tabstop, vim.o.shiftwidth)
end

local function my_sections()
	return printf('%s %s', location(), spaces())
end

local diagnostics = {
	'diagnostics',

	-- Table of diagnostic sources, available sources are:
	--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
	-- or a function that returns a table as such:
	--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
	sources = { 'nvim_diagnostic' },

	-- Displays diagnostics for the defined severity types
	sections = { 'error', 'warn', 'info', 'hint' },

	diagnostics_color = {
		-- Same values as the general color option can be used here.
		error = { fg = colors.red, bg = sec_c_bg },
		warn  = { fg = colors.yellow, bg = sec_c_bg },
		info  = { fg = colors.blue, bg = sec_c_bg },
		hint  = { fg = colors.cyan, bg = sec_c_bg },
	},

	symbols = {
		icons = { error = '', warn = '', info = '', hint = '' },
	},

	colored = true, -- Displays diagnostics status in color if set to true.
	update_in_insert = false, -- Update diagnostics in insert mode.
	always_visible = false, -- Show diagnostics even if there are none.
}

function M.config()
	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = theme(),
			-- component_separators = { left = '', right = '' },
			component_separators = { left = '│', right = '│' },
			section_separators = { left = '', right = '' },

			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},

			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,

			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},

		sections = {
			lualine_a = { getMode },

			lualine_b = { { 'branch', icon = '' } },

			lualine_c = {
				{
					'filename',
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = true, -- Display new file status (new file means no write after created)
					path = 1, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					symbols = {
						modified = '[*]', -- Text to show when the file is modified.
						readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
						unnamed = '[No Name]', -- Text to show for unnamed buffers.
						newfile = '[New]', -- Text to show for new created file before first writting
					}
				}
			},

			lualine_x = {
				diagnostics, my_sections, 'filesize',
			},

			lualine_y = { 'filetype' },

			lualine_z = {
				'encoding', 'fileformat', mixLine, paste,
			},

		},

		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		},

		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
end

return M
