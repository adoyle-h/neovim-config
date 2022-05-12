-- No more used. It is only for packer.nvim

local M = {}

function M.setup(use)
	-- it is necessary
	use 'wbthomason/packer.nvim'

	-- Many plugin require plenary.nvim
	use 'nvim-lua/plenary.nvim'
	use 'rcarriga/nvim-notify'
	use 'liuchengxu/vista.vim'

	use(require('adoyle-neovim-config.plugins.color-theme'))
	use(require('adoyle-neovim-config.plugins.colorizer'))
	use(require('adoyle-neovim-config.plugins.treesitter'))
	use(require('adoyle-neovim-config.plugins.search'))
	use(require('adoyle-neovim-config.plugins.scrollbar')) -- scrollbar must put after search
	use(require('adoyle-neovim-config.plugins.todo'))
	use(require('adoyle-neovim-config.plugins.telescope'))
	use(require('adoyle-neovim-config.plugins.completion'))
	use(require('adoyle-neovim-config.plugins.lsp'))
	use(require('adoyle-neovim-config.plugins.indent'))
end

return M
