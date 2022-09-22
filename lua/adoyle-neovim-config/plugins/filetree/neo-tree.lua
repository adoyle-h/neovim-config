local M = {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v2.x',
	disable = false,
	on = {},
	requires = {
		'MunifTanjim/nui.nvim',
		{
			-- only needed if you want to use the commands with "_with_window_picker" suffix
			's1n7ax/nvim-window-picker',
			tag = 'v1.*',
			config = function()
				require'window-picker'.setup({
					autoselect_one = true,
					include_current = false,
					filter_rules = {
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { 'neo-tree', 'neo-tree-popup', 'notify', 'quickfix' },

							-- if the buffer type is one of following, the window will be ignored
							buftype = { 'terminal' },
						},
					},
					other_win_hl_color = '#14482F',
				})
			end,
		},
	},
}

local function configKeymaps()
	vim.cmd [[
		noremap <space>m :Neotree toggle<CR>
		noremap <silent> <leader>nm :Neotree toggle<CR>
		noremap <space>b :Neotree toggle show buffers<CR>
		noremap <silent> <leader>nb :Neotree toggle show buffers<CR>
		noremap <space>g :Neotree toggle show git_status<CR>
		noremap <silent> <leader>ng :Neotree toggle show git_status<CR>
		noremap <silent> <leader>nf :Neotree reveal<CR>
	]]
end

function M.config()
	local config = require('adoyle-neovim-config.config').config
	local ftConf = config.filetree
	local symbols = config.symbolMap

	require('neo-tree').setup {
		log_level = 'warn',
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = 'rounded',
		enable_git_status = true,
		enable_diagnostics = true,
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		sort_function = nil, -- use a custom function for sorting files and directories in the tree

		default_component_configs = {
			container = {
				enable_character_fade = false,
				-- width = 'fit_content',
			},

			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = '│',
				last_indent_marker = '└',
				highlight = 'NeoTreeIndentMarker',
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = '',
				expander_expanded = '',
				expander_highlight = 'NeoTreeExpander',
			},

			icon = {
				folder_closed = '',
				folder_open = '',
				folder_empty = '',
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = '',
				highlight = 'NeoTreeFileIcon',
			},

			modified = { symbol = '', highlight = 'NeoTreeModified' },

			name = { trailing_slash = false, use_git_status_colors = true, highlight = 'NeoTreeFileName' },

			git_status = {
				symbols = {
					added = symbols.ADDED,
					modified = symbols.MODIFIED,
					deleted = symbols.DELETED,
					renamed = symbols.RENAMED,
					untracked = symbols.GIT_UNTRACKED,
					ignored = symbols.GIT_IGNORED,
					unstaged = symbols.GIT_UNSTAGED,
					staged = symbols.GIT_STAGED,
					conflict = symbols.GIT_CONFLICT,
				},
			},
		},

		window = {
			position = 'left',
			width = 34,

			mapping_options = { noremap = true, nowait = true },
			mappings = {
				['?'] = 'show_help',
				['q'] = 'close_window',
				['<C-r>'] = 'refresh',
				['<2-LeftMouse>'] = 'open',
				['<cr>'] = 'open',
				['o'] = 'open',
				['O'] = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()

					-- :h feature-list
					if vim.fn.has('mac') then
						vim.api.nvim_command('!open -R ' .. path) -- Open it in Finder
					elseif vim.fn.has('linux') then
						vim.api.nvim_command(string.format('!xdg-open "%s"', path))
					end
				end,
				['C'] = 'close_node',
				['s'] = 'open_split',
				['v'] = 'open_vsplit',
				-- ['S'] = 'split_with_window_picker',
				-- ['s'] = 'vsplit_with_window_picker',
				['t'] = 'open_tabnew',
				-- ['w'] = 'open_with_window_picker',
				['w'] = false,
				['<space>'] = false,
				['<bs>'] = false,
				-- ['P'] = 'toggle_preview', -- enter preview mode, which shows the current node without focusing
				['z'] = 'close_all_nodes',
				['Z'] = 'expand_all_nodes',
				['d'] = 'delete',
				['r'] = 'rename',
				['y'] = 'copy_to_clipboard',
				['x'] = 'cut_to_clipboard',
				['p'] = 'paste_from_clipboard',
				['a'] = {
					'add',
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = 'relative', -- 'none', 'relative', 'absolute'
					},
				},
				['A'] = {
					'add_directory',
					config = {
						show_path = 'relative', -- 'none', 'relative', 'absolute'
					},
				},
				['c'] = {
					'copy',
					config = {
						show_path = 'relative', -- 'none', 'relative', 'absolute'
					},
				},
				['m'] = {
					'move',
					config = {
						show_path = 'relative', -- 'none', 'relative', 'absolute'
					},
				},
				['<'] = 'prev_source',
				['>'] = 'next_source',
			},
		},

		nesting_rules = {},

		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = ftConf.hideByName,
				hide_by_pattern = { -- uses glob style patterns
					-- '*.meta',
					-- '*/src/*/tsconfig.json',
				},
				always_show = ftConf.alwaysShow,
				never_show = ftConf.neverShow,
			},

			follow_current_file = false, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- 'open_current',  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- 'disabled',    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes

			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					['<C-h>'] = 'navigate_up',
					['<C-l>'] = 'set_root',
					['H'] = 'toggle_hidden',
					['/'] = 'fuzzy_finder',
					['D'] = 'fuzzy_finder_directory',
					['f'] = 'filter_on_submit',
					['<c-x>'] = 'clear_filter',
					['[g'] = 'prev_git_modified',
					[']g'] = 'next_git_modified',
				},
			},
		},

		buffers = {
			follow_current_file = true, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			show_unloaded = true,
			window = { position = 'float', mappings = { ['d'] = 'buffer_delete' } },
		},

		git_status = {
			window = {
				position = 'float',
				mappings = {
					['A'] = 'git_add_all',
					['u'] = 'git_unstage_file',
					['a'] = 'git_add_file',
					['r'] = 'git_revert_file',
				},
			},
		},

		source_selector = {
			winbar = false, -- toggle to show selector on winbar
			statusline = false, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- boolean
			tab_labels = {
				filesystem = '  Files ', -- string | nil
				buffers = ' ﬘ Buffers ', -- string | nil
				git_status = '  Git ', -- string | nil
				diagnostics = ' 裂Diagnostics ', -- string | nil
			},
		},
	}

	configKeymaps()
end

return M
