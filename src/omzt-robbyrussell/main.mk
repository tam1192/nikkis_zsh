$(BUILD_DIR)/omzt-robbyrussell.main: $(BUILD_DIR)/omzt-robbyrussell/main.zsh
	@cp $^ $@

$(BUILD_DIR)/omzt-robbyrussell.alias:
	@touch $@

$(BUILD_DIR)/omzt-robbyrussell.path:
	@touch $@

ifneq ($(filter-out omzt-robbyrussell,$(filter omzt-%,$(MODULES))),)
    $(error [FATAL ERROR] 他のomzテーマモジュールを含んでいます。 ビルドを強制終了します。)
endif

ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

$(OUT_DIR)/$(CONFIG_DIR)/omzt-robbyrussell.d:
	@mkdir -p $@
