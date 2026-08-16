$(BUILD_DIR)/omzc-zsh-autosuggestions.main:
	@touch $@

$(BUILD_DIR)/omzc-zsh-autosuggestions.alias:
	@touch $@

$(BUILD_DIR)/omzc-zsh-autosuggestions.path:
	@touch $@

$(BUILD_DIR)/omzc-zsh-autosuggestions.omzp: $(BUILD_DIR)/omzc-zsh-autosuggestions/omzp.zsh
	@cp $^ $@

ifeq ($(filter omzc,$(MODULES)),)
    $(error [FATAL ERROR] omzcモジュールが必要です。 ビルドを強制終了します。)
endif

$(OUT_DIR)/$(CONFIG_DIR)/omzc.d/plugins/zsh-autosuggestions: $(OUT_DIR)/$(CONFIG_DIR)/omzc.d
	@mkdir -p $@
	@cp -r $(SRC_DIR)/omzc-zsh-autosuggestions/zsh-autosuggestions/* $@

$(OUT_DIR)/$(CONFIG_DIR)/omzc-zsh-autosuggestions.d: $(OUT_DIR)/$(CONFIG_DIR)/omzc.d/plugins/zsh-autosuggestions
# $^を作成するためにダミーで設置
	@mkdir -p $@
