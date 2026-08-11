$(BUILD_DIR)/basic.main: $(BUILD_DIR)/basic/main.zsh
	@cp $^ $@

$(BUILD_DIR)/basic.alias: $(BUILD_DIR)/basic/alias.zsh
	@cp $^ $@ 

$(BUILD_DIR)/basic.path:
	@touch $@ 

$(OUT_DIR)/$(CONFIG_DIR)/basic.d:
	@mkdir -p $@