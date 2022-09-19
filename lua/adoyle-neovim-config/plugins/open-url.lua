local M = {
	'tyru/open-browser.vim',
	on = { '<Plug>(openbrowser-smart-search)', '<Plug>(openbrowser-open)' },
	desc = 'Open url from text with browser',
	disable = false,
	-- requires = {},
	-- ['for'] = '',
}

function M.config()
	-- disable netrw's gx mapping
	vim.g.netrw_nogx = 1

	vim.cmd [[
		nmap gx <Plug>(openbrowser-smart-search)
		vmap gx <Plug>(openbrowser-smart-search)
		nmap gX <Plug>(openbrowser-open)
		vmap gX <Plug>(openbrowser-open)
	]]
end

return M
