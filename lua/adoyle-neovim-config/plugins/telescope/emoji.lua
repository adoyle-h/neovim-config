return {
	'xiyaowong/telescope-emoji.nvim',

	config = function(config)
		require('telescope').setup { extensions = { emoji = config.telescope.emoji } }
		require('telescope').load_extension('emoji')
	end,

	defaultConfig = {
		{ 'telescope', 'emoji' },
		{
			action = function(emoji)
				-- argument emoji is a table.
				-- {name="", value="", cagegory="", description=""}

				vim.fn.setreg('"', emoji.value)
				vim.schedule(function()
					print('Press "p" to paste emoji ' .. emoji.value)
				end)

				-- insert emoji when picked
				-- vim.api.nvim_put({ emoji.value }, 'c', false, true)
			end,
		},
	},
}
