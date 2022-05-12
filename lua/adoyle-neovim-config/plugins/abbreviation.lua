local M = {
	'tpope/vim-abolish',
	desc = 'easily search for, substitute, and abbreviate multiple variants of a word',
	disable = false,
	-- requires = {},
	-- ['for'] = '',
}

-- vim-abolish the default keymaps. ":h cr" for more descriptions
-- https://github.com/tpope/vim-abolish#coercion
-- MixedCase (crm)
-- camelCase (crc)
-- snake_case (crs or cr_)
-- SNAKE_UPPERCASE (cru)
-- dash-case (cr-)
-- kebab-case (crk)
-- dot.case (cr.)
-- space case (cr<space>)

function M.config()
	vim.g.abolish_save_file = vim.fn.expand('<sfile>:p')

	-- vim.cmd [[
	--   autocmd VimEnter * source $NVIM_HOME/abbreviations.vim
	-- ]]
end

function M.setup()
	-- vim.cmd [[
		-- " See https://github.com/tpope/vim-abolish/#abbreviation
		-- Abolish funciton function
		-- Abolish teh the
		-- Abolish tempalte template
		-- Abolish fitler filter
	-- ]]
end

return M
