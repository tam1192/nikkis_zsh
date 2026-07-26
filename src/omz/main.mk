$(BUILD_DIR)/omz.main: $(BUILD_DIR)/omz/main.zsh
	@cp $^ $@

$(BUILD_DIR)/omz.alias:
	@touch $@

$(BUILD_DIR)/omz.path:
	@touch $@

ifneq ($(filter core,$(MODULES)),)
    # リストの中に X が【含まれている】場合の処理
    $(error [FATAL ERROR] MODULESの中に 'core' が含まれています。ビルドを強制終了します。)
endif

$(OUT_DIR)/$(CONFIG_DIR)/omz.d:
	@mkdir -p $@
	@cp -r $(SRC_DIR)/omz/ohmyzsh/* $@