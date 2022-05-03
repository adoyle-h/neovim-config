local M = {}

function M.setup(use)
	-- it is necessary
	use 'wbthomason/packer.nvim'

	-- Many plugin require plenary.nvim
	use 'nvim-lua/plenary.nvim'
	use 'rcarriga/nvim-notify'
	use 'liuchengxu/vista.vim'

	use(require('plugins.color-theme'))
	use(require('plugins.colorizer'))
	use(require('plugins.treesitter'))

	use(require('plugins.search'))
	use(require('plugins.scrollbar')) -- scrollbar must put after search
	use(require('plugins.todo'))
	use(require('plugins.telescope'))
	use(require('plugins.completion'))
	use(require('plugins.lsp'))
	use(require('plugins.indent'))
end

return M
