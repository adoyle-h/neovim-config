local M = {
	nil,
	desc = 'Profiling tools',
	-- Enable it when need profiling.
	disable = true,
}

M.requires = {
	{ 'dstein64/vim-startuptime', desc = 'Launch vim-startuptime with :StartupTime' },
}

return M
