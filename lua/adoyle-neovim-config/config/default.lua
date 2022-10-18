-- User should not change this file. Edit require('adoyle-neovim-config').setup({config}) in your init.lua.
return function(colors)
	local symbol = require('adoyle-neovim-config.config.symbol')

	return {
		colors = colors,

		symbolMap = symbol.symbolMap,

		kindSymbolMap = symbol.kindSymbolMap,

		theme = {
			use = 'onedarkpro', -- 'onedarkpro' or 'material',
		},

		-- Global lua variable. So you can easily call the framework, like ":lua a.util"
		-- If set nil or false, do not create this variable.
		global = 'a',

		pluginManager = {
			-- All plugins are downloaded in this directory
			-- Default: ~/.local/share/nvim/plugins
			pluginDir = vim.fn.stdpath('data') .. '/plugins',
			timeout = 30,
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
				'nerdtree', 'NvimTree', 'neo-tree', 'notify', 'Trouble', 'Mundo', 'mason', 'man', 'alpha',
				'PlenaryTestPopup',
				-- LuaFormatter on
			},
		},

		-- More options defined in "defaultConfig" of each plugin
	}
end
