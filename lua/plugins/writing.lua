local M = {
	'junegunn/goyo.vim',
	disable = false,
	desc = '禅意协作模式',
	on = 'Goyo',
	['for'] = 'markdown',

	requires = {
		{
			'junegunn/limelight.vim',
			desc = '高亮当前代码块',
			['for'] = 'markdown',
		},
	},
}

local function goyoEnter()
	vim.opt.showmode = false
	vim.opt.showcmd = false
	vim.o.scrolloff = 999 - vim.o.scrolloff

	vim.cmd [[
		"let &scrolloff=999-&scrolloff
		Limelight
	]]
end

local function goyoLeave()
	vim.opt.showmode = true
	vim.opt.showcmd = true
	vim.o.scrolloff = 999 - vim.o.scrolloff

	vim.cmd [[
		"let &scrolloff=999-&scrolloff
		Limelight!
	]]
end

local GoyoGroup = vim.api.nvim_create_augroup('GoyoGroup', { clear = true })

local function configGoyo()
	vim.g.goyo_width = '120' -- (default: 80)
	vim.g.goyo_height = '90%' -- (default: 85%)
	vim.g.goyo_linenr = 1 -- (default: 0)

	vim.api.nvim_create_autocmd({'User'}, {
		pattern = {'GoyoEnter'},
		group = GoyoGroup,
		nested = true,
		callback = goyoEnter,
	})

	vim.api.nvim_create_autocmd({'User'}, {
		pattern = {'GoyoLeave'},
		group = GoyoGroup,
		nested = true,
		callback = goyoLeave,
	})
end

local function configLime()
	vim.g.limelight_conceal_ctermfg = 'gray'
	vim.g.limelight_conceal_ctermfg = 240
	vim.g.limelight_conceal_guifg = 'DarkGray'
	vim.g.limelight_conceal_guifg = '#A9A9A9'
end


function M.config()
	configGoyo()
	configLime()
end

return M
