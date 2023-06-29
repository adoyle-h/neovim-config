.PHONY: init-full
init-full:
	ln -fs ./full.lua init.lua

PACK_DIR=$(HOME)/.local/share/nvim/site/pack/user/start

.PHONY: init-lite
init-lite:
	ln -fs ./lite.lua init.lua
	@mkdir -p "$(PACK_DIR)"
	@[[ ! -d "$(PACK_DIR)"/one.nvim ]] && git clone https://github.com/adoyle-h/one.nvim.git "$(PACK_DIR)" || true
	@[[ ! -d "$(PACK_DIR)"/netrw.nvim ]] && git clone https://github.com/prichrd/netrw.nvim.git "$(PACK_DIR)" || true
