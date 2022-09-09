-- This file is loaded by neovim. See `:h init.lua`

require('adoyle-neovim-config').setup {
	-- This config is an example for personal usage.
	config = {
		colorcolumn = { 80, 100 }, -- highlight columns. See ":h 'cc'"

		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
			-- Otherwise, remove this option.
			github = 'https://ghproxy.com/', -- emptry string or proxy url
		},

		pluginOpts = {
			['plugins.profiling'] = {
				disable = false,
			},
		},

		plugins = {
			{ 'psliwka/vim-smoothie', disable = true },
		},
	},
}
