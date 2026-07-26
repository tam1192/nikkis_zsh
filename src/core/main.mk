$(BUILD_DIR)/core.main: $(BUILD_DIR)/core/main.zsh
	@cp $^ $@

$(BUILD_DIR)/core.alias:
	@touch $@

$(BUILD_DIR)/core.path:
	@touch $@

$(OUT_DIR)/$(CONFIG_DIR)/core.d:
	@mkdir -p $@