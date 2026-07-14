$(OUT_DIR)/core.main: $(OUT_DIR)/core/main.zsh
	@cp $^ $@

$(OUT_DIR)/core.alias:
	@touch $@

$(OUT_DIR)/core.path:
	@touch $@
