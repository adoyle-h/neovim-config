local M = {
	'kyazdani42/nvim-tree.lua',
	disable = false,
	on = {},
	requires = {
		'kyazdani42/nvim-web-devicons',
	}
}

local function configKeymaps()
	vim.cmd [[
		noremap <silent> <leader>nm :NvimTreeToggle<CR>
		noremap <silent> <leader>nf :NvimTreeFindFile<CR>
		noremap <space>m :NvimTreeToggle<CR>
	]]
end

function M.config()
	require('nvim-tree').setup({
		sort_by = 'case_sensitive',

		remove_keymaps = { 'bmv' },

		view = {
			width = 30,

			mappings = {
				list = {
					{ key = '?', action = 'toggle_help' },
					{ key = 'H', action = 'dir_up' },
					{ key = { 'L', '<C-]>', '<2-RightMouse>' }, action = 'cd' },
					{ key = 'v', action = 'vsplit' },
					{ key = 's', action = 'split' },
					{ key = 't', action = 'tabnew' },
					{ key = 'i', action = 'toggle_dotfiles' },
					{ key = 'p', action = 'parent_node' },
					{ key = 'P', action = 'paste' },
				},
			},

			float = {
				enable = false,
			},
		},

		renderer = {
			group_empty = true,

			icons = {
				symlink_arrow = " ➜ ",

				glyphs = {
					git = {
						unstaged = "*",
						staged = "",
						unmerged = "",
						renamed = "➜",
						untracked = "✣",
						deleted = "",
						ignored = "◌",
					},
				},
			},

		},

		filters = {
			dotfiles = true,
		},

		actions = {
			use_system_clipboard = true,
		},

	})

	vim.cmd.hi { 'NvimTreeNormal', 'guibg=#18191' }

	configKeymaps()
end

return M
