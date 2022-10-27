return {
	'image',

	requires = { 'edluffy/hologram.nvim', 'askfiy/nvim-picgo', 'ekickx/clipboard-image.nvim' },

	config = function(config)
		local conf = config.image
		require('').setup(conf)
	end,

	defaultConfig = { { 'image' }, {} },
}
