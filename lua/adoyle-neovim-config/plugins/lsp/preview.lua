return {
	'rmagatti/goto-preview',

	defaultConfig = {
		{ 'lsp', 'preview' },
		{
			width = 80, -- Width of the floating window
			height = 15, -- Height of the floating window
			border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
			default_mappings = false, -- Bind default mappings
			debug = false, -- Print debug information
			opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
			resizing_mappings = false, -- Binds arrow keys to resizing the floating window.

			post_open_hook = function() -- A function taking two arguments, a buffer and a window to be ran as a hook.
				vim.wo.cc = '';
			end,

			-- references = { -- Configure the telescope UI for slowing the references cycling window.
			--   telescope = telescope.themes.get_dropdown({ hide_preview = false })
			-- };

			-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
			focus_on_open = true, -- Focus the floating window when opening it.
			dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
			force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
			bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
		},
	},

	config = function(config)
		require('goto-preview').setup(config.lsp.preview)
	end,

	commands = function()
		return {
			{ 'ClearPreviews', require('goto-preview').close_all_win, { desc = 'close all preview windows' } },
		}
	end,

	keymaps = function()
		local preview = require('goto-preview')
		return {
			{
				'n',
				'gD',
				vim.lsp.buf.definition,
				{ desc = 'Jump to the definition of the symbol under the cursor' },
			},

			{
				'n',
				'gd',
				preview.goto_preview_definition,
				{ desc = 'Open float window to query the definition of the symbol under the cursor' },
			},

			{ 'n', 'gt', preview.goto_preview_type_definition, { desc = 'goto_preview_type_definition' } },
			{ 'n', 'gi', preview.goto_preview_implementation, { desc = 'goto_preview_implementation' } },
			{ 'n', 'gr', preview.goto_preview_references, { desc = 'goto_preview_references' } },
		}
	end,
}
