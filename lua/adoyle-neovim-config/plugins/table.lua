local M = {
	'dhruvasagar/vim-table-mode',
	desc = '格式化表格',
	on = 'TableModeToggle',
	disable = false,
	requires = {},
}

local function changeTableMode()
	local b = vim.b
	if (b.table_mode_mode == 'Normal') then
		b.table_mode_corner = '|'
		b.table_mode_separator = '|'
		b.table_mode_fillchar = '-'
		b.table_mode_corner_corner = '|'
		b.table_mode_align_char = ':'
		b.table_mode_mode = 'GFM'
	else
		b.table_mode_corner = '+'
		b.table_mode_separator = '|'
		b.table_mode_fillchar = '-'
		b.table_mode_corner_corner = '+'
		b.table_mode_align_char = ':'
		b.table_mode_mode = 'Normal'
	end

	print('Table Mode: ' .. b.table_mode_mode)
end

function M.config()
	local g = vim.g
	g.table_mode_motion_up_map = '[{'
	g.table_mode_motion_down_map = ']}'
	g.table_mode_motion_left_map = '[['
	g.table_mode_motion_right_map = ']]'
	g.table_mode_map_prefix = '<leader>T'

	vim.keymap.set('n', '<leader>Tm', function()
		vim.b.table_mode_mode = 'GFM'
		vim.cmd.TableModeToggle()
	end, { noremap = true, desc = 'Toggle TableMode' })

	vim.keymap.set('n', '<leader>Tc', changeTableMode, { noremap = true, desc = 'Change TableMode' })
end

return M
