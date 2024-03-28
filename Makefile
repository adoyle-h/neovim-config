PACK_DIR=$(HOME)/.local/share/nvim/site/pack/user/start

.PHONY: init-full
init-full: $(PACK_DIR) $(PACK_DIR)/one.nvim
	ln -fs ./full.lua init.lua

.PHONY: init-lite
init-lite: $(PACK_DIR) $(PACK_DIR)/one.nvim
	ln -fs ./lite.lua init.lua

.PHONY: init-reproduce
init-lite: $(PACK_DIR) $(PACK_DIR)/one.nvim
	ln -fs ./reproduce.lua init.lua

$(PACK_DIR):
	@mkdir -p "$(PACK_DIR)"

$(PACK_DIR)/one.nvim:
	git clone https://github.com/adoyle-h/one.nvim.git "$(PACK_DIR)"/one.nvim
