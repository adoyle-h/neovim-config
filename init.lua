require('adoyle-neovim-config').setup {
	config = {
		-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/')
		github = 'https://ghproxy.com/', -- emptry string or proxy url

		plugins = {
			['plugins.profiling'] = {
				disable = true,
			},
		},
	},

	plugins = function(A)
		A.Plug { 'psliwka/vim-smoothie', disable = false }
	end,
}
