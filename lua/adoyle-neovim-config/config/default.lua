-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.
return function(colors)
	local symbol = require('adoyle-neovim-config.config.symbol')

	return {
		colors = colors, -- basic colors

		symbolMap = symbol.symbolMap,

		kindSymbolMap = symbol.kindSymbolMap,

		theme = {
			use = 'onedarkpro', -- 'onedarkpro' or 'material',
		},

		-- Global lua variable. So you can easily call the framework, like ":lua a.util"
		-- If set nil or false, do not create this variable.
		global = 'a',

		-- https://github.com/junegunn/vim-plug#global-options
		pluginManager = {
			-- All plugins are downloaded in this directory. Default: ~/.local/share/nvim/plugins
			pluginDir = vim.fn.stdpath('data') .. '/plugins',
			timeout = 30,
			threads = 8,
			retries = 2,
			shallow = 1,
			window = 'vertical topleft new',
			pwindow = 'above 12new',
		},

		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
			github = '', -- emptry string or proxy url
		},

		ignore = {
			fileSearch = { --
				directories = { 'node_modules', '.git', 'vendor' },
				files = {},
			},

			fileTypesForSomePlugs = {
				-- LuaFormatter off
				'TelescopePrompt', 'TelescopeResults', 'lsp-installer', 'null-ls-info', 'lspinfo', 'aerial',
				'nerdtree', 'NvimTree', 'neo-tree', 'notify', 'Trouble', 'Mundo', 'mason', 'man', 'alpha', 'calendar',
				'PlenaryTestPopup', 'noice',
				-- LuaFormatter on
			},
		},

		-- More options defined in "defaultConfig" of each plugin
	}
end
