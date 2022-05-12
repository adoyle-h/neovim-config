local M = {
	'dhruvasagar/vim-table-mode',
	desc = '格式化表格',
	on = 'TableModeToggle',
	disable = false,
	requires = {},
}


local function TableModeChange()
  if (vim.b.table_mode_mode == 'Normal') then
    vim.b.table_mode_corner = '|'
    vim.b.table_mode_separator = '|'
    vim.b.table_mode_fillchar = '-'
    vim.b.table_mode_corner_corner = '|'
    vim.b.table_mode_align_char = ':'
    vim.b.table_mode_mode = 'GFM'
	else
    vim.b.table_mode_corner = '+'
    vim.b.table_mode_separator = '|'
    vim.b.table_mode_fillchar = '-'
    vim.b.table_mode_corner_corner="+"
    vim.b.table_mode_align_char = ':'
    vim.b.table_mode_mode = 'Normal'
  end
  return 'Table Mode: ' .. vim.b.table_mode_mode
end


function M.config()
	vim.g.table_mode_motion_up_map = '[{'
	vim.g.table_mode_motion_down_map = ']}'
	vim.g.table_mode_motion_left_map = '[['
	vim.g.table_mode_motion_right_map = ']]'

	vim.api.nvim_create_autocmd(
		{ 'BufNew', 'BufRead' },
		{
			pattern = '*',
			callback = function()
				vim.b.table_mode_mode = 'GFM'
				TableModeChange()
			end
		}
	)

	vim.cmd [[
		noremap <leader>tm :TableModeToggle<CR>
		noremap <leader>tc :echomsg TableModeChange()<CR>
	]]
end

return M
