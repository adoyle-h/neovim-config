local M = {
	'lewis6991/gitsigns.nvim',
	desc = 'Vim gutter sign and git blame float window',
	disable = false,
}

function M.config()
	local gs = require('gitsigns')

	gs.setup {
		signs = {
			add = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			change = {
				hl = 'GitSignsChange',
				text = '┃',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
			delete = {
				hl = 'GitSignsDelete',
				text = '_',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			topdelete = {
				hl = 'GitSignsDelete',
				text = '‾',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			changedelete = {
				hl = 'GitSignsChange',
				text = '┃',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = { interval = 1000, follow_files = true },
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 100,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = '[<author_time:%Y/%m/%d %H:%M:%S> <author>] <summary>',
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = 'single',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
		yadm = { enable = false },
		on_attach = function(bufnr)
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map('n', ']g', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return '<Ignore>'
			end, { expr = true })

			map('n', '[g', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return '<Ignore>'
			end, { expr = true })

			-- Actions
			map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' })
			map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
			map('n', '<leader>G', ':Gitsigns<CR>')
			map('n', '<leader>gS', gs.stage_buffer, { desc = 'stage buffer' })
			map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo staged hunk' })
			map('n', '<leader>gR', gs.reset_buffer, { desc = 'reset buffer' })
			map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview hunk' })
			map('n', '<leader>gb', function()
				gs.blame_line { full = true }
			end, { desc = 'blame line' })
			map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'toggle current line blame' })
			map('n', '<leader>gd', gs.toggle_deleted, { desc = 'toggle deleted' })
			map('n', '<leader>gD', function()
				gs.diffthis('~')
			end, { desc = 'diff this with HEAD~ ' })

			-- Text object
			-- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

			vim.api.nvim_create_user_command('GitBlameToggle', function()
				gs.toggle_current_line_blame()
			end, {})
		end,
	}
end

return M
