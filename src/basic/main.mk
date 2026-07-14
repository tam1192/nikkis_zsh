$(OUT_DIR)/basic.main: $(OUT_DIR)/basic/main.zsh
	@cp $^ $@

$(OUT_DIR)/basic.alias: $(OUT_DIR)/basic/alias.zsh
	@cp $^ $@ 

$(OUT_DIR)/basic.path:
	@touch $@ 
