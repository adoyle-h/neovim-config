require('one').setup {
	config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
			github = 'https://ghproxy.com',
		},

		global = 'a',

		pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer'
	},
}
