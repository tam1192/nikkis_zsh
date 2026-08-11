$(BUILD_DIR)/vim.main: $(BUILD_DIR)/vim/main.zsh
	@cp $^ $@

$(BUILD_DIR)/vim.alias: $(BUILD_DIR)/vim/alias.zsh
	@cp $^ $@

$(BUILD_DIR)/vim.path:
	@touch $@

$(OUT_DIR)/$(CONFIG_DIR)/vim.d:
	@mkdir -p $@
