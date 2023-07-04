PACK_DIR=$(HOME)/.local/share/nvim/site/pack/user/start

.PHONY: init-full
init-lite: $(PACK_DIR) $(PACK_DIR)/one.nvim
	ln -fs ./full.lua init.lua

.PHONY: init-lite
init-lite: $(PACK_DIR) $(PACK_DIR)/one.nvim
	@[[ ! -d "$(PACK_DIR)"/netrw.nvim ]] && git clone https://github.com/prichrd/netrw.nvim.git "$(PACK_DIR)"/netrw.nvim || true
	ln -fs ./lite.lua init.lua

$(PACK_DIR):
	@mkdir -p "$(PACK_DIR)"

$(PACK_DIR)/one.nvim:
	git clone https://github.com/adoyle-h/one.nvim.git "$(PACK_DIR)"/one.nvim
