return {
	config = function()
		local source = require('adoyle-neovim-config.plugins.completion.dynamic.source')
		require('cmp').register_source('dynamic', source)
	end,

	completions = {
		today = {
			callback = function()
				return os.date('%Y/%m/%d')
			end,
		},
	},
}
