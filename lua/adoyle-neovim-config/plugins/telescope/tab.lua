return {
	'LukasPietzschmann/telescope-tabs',

	keymaps = { { 'n', '<space>t', ':Telescope telescope-tabs list_tabs<CR>' } },

	config = function(config)
		require('telescope-tabs').setup(config.telescope.tabs)
		require('telescope').load_extension('telescope-tabs')
	end,

	defaultConfig = {
		{ 'telescope', 'tabs' },
		{
			entry_formatter = function(tab_id, buffer_ids, file_names, file_paths)
				local entry_string = table.concat(vim.tbl_filter(function(f)
					return #f > 0
				end, file_names), ', ')

				return string.format('%d: %s', tab_id, entry_string)
			end,
			show_preview = true,
			close_tab_shortcut = '<C-x>',
		},
	},
}
