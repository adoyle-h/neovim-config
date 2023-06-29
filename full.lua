require('one').setup {
	config = require('my.config').config,

	---@diagnostic disable-next-line: unused-local
	configFn = require('my.config').configFn,

	-- Add your plugins or override plugin default options.
	plugins = require('my.plugins'),

	-- @param [opts.onlyPlugins] {string[]|nil}
	-- It's useful for debug. Defaults to nil.
	-- If set empty table, all builtin and user-defined plugins are disabled.
	-- If set non-empty table, only these plugins are not disabled.
	-- onlyPlugins = { 'one', 'pl', 'alpha', 'adoyle-h/alpha-nvim', 'session', 'olimorris/persisted.nvim' },
}
