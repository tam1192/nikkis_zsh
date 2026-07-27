$(BUILD_DIR)/omzc.main: $(BUILD_DIR)/omzc/main.zsh
	@cp $^ $@

$(BUILD_DIR)/omzc.alias:
	@touch $@

$(BUILD_DIR)/omzc.path:
	@touch $@

ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

$(OUT_DIR)/$(CONFIG_DIR)/omzc.d:
	@mkdir -p $@
	@cp -r $(SRC_DIR)/omzc/zsh_custom/* $@
