$(OUT_DIR)/vim.main: $(OUT_DIR)/vim/main.zsh
	@cp $^ $@

$(OUT_DIR)/vim.alias: $(OUT_DIR)/vim/alias.zsh
	@cp $^ $@

$(OUT_DIR)/vim.path:
	@touch $@

