return {
	'kyazdani42/nvim-web-devicons',

	defaultConfig = {
		'devicons',
		{
			override = {
				-- Each icon must have "name" property
				['.gitattributes'] = { icon = '', color = '#FA4F28', name = 'GitAttributes' },
				['.gitconfig'] = { icon = '', color = '#FA4F28', name = 'GitConfig' },
				['.gitignore'] = { icon = '', color = '#FA4F28', name = 'GitIgnore' },
				['.gitlab-ci.yml'] = { icon = '', color = '#FC6D26', name = 'GitlabCI' },
				['.gitmodules'] = { icon = '', color = '#FA4F28', name = 'GitModules' },
				['.lua-format'] = { icon = '', color = '#28A2D4', name = 'LuaFormatter' },
				['.editorconfig'] = { icon = '', color = '#BEC0C4', name = 'EditorConfig' },
				['.eslintrc.yml'] = { icon = '', color = '#8080F2', name = 'EslintRC' },
				['.prettierignore'] = { icon = '', color = '#C794C8', name = 'PrettierIgnore' },
			},
		},
	},

	config = function()
		local config = require('adoyle-neovim-config.config').config
		require('nvim-web-devicons').setup { override = config.devicons.override }
	end,
}
