local M = {
 'luochen1990/rainbow',
	desc = '括号颜色配对。Attention: 可能会影响到其他语法着色',
	disable = false,
}

function M.config()
	vim.g.rainbow_active = 1 -- Or 0 if you want to enable it later via :RainbowToggle
	vim.g.rainbow_conf = {
		ctermfgs = {'24', '166', '119', '33', '48', '229', '202', '4', '13', '105', '101'},

		guifgs = {'#005f87', '#d75f00', '#87ff5f', '#0087ff', '#00ff87', '#ffffaf', '#ff5f00', '#000080', '#ff00ff', '#8787ff', '#87875f'},

		separately = {
			nerdtree = 0,
		},
	}
end

return M
