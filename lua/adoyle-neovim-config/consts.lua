local levels = vim.log.levels

return {
	log = {
		levelMap = {
			[levels.ERROR] = 'ERROR',
			[levels.WARN] = 'WARN',
			[levels.INFO] = 'INFO',
			[levels.TRACE] = 'TRACE',
			[levels.DEBUG] = 'DEBUG',
			[levels.OFF] = 'OFF',
		},
	},
}
