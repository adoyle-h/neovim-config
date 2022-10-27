return {
	'tamago324/nlsp-settings.nvim',

	config = function(config)
		require('nlspsettings').setup(config.nlsp)
	end,

	defaultConfig = {
		'nlsp',
		{
			-- For global settings,
			config_home = vim.fn.stdpath('config') .. '/lsp-settings',
			-- For local project, put settings file in {project}/.lsp-settings/{server_name}.yaml.
			local_settings_dir = '.nlsp-settings',
			local_settings_root_markers_fallback = { '.git' },
			append_default_schemas = true,
			loader = 'yaml',
		},
	},
}
