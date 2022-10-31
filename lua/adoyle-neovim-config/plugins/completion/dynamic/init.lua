return {

	config = function()
		local source = require('adoyle-neovim-config.plugins.completion.dynamic.source')
		local has_cmp, cmp = pcall(require, 'cmp')
		if has_cmp then cmp.register_source('dynamic', source) end
	end,

	completions = {
		today = {
			callback = function()
				return os.date('%Y/%m/%d')
			end,
		},
	},

}
