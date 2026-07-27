OMZ_PLUGINS_FILE  := $(CONFIG_DIR)/omz_plugins.zsh
OMZ_PLUGINS_FILES  := $(patsubst %,$(BUILD_DIR)/%.omzp,$(filter omz%, $(MODULES)))
ALLS += $(OUT_DIR)/$(OMZ_PLUGINS_FILE)

$(BUILD_DIR)/omz.main: $(BUILD_DIR)/omz/main.zsh
	@cp $^ $@

$(BUILD_DIR)/omz.omzp: $(BUILD_DIR)/omz/omzp.zsh
	@cp $^ $@

$(BUILD_DIR)/omz.alias:
	@touch $@

$(BUILD_DIR)/omz.path:
	@touch $@ 

ifneq ($(filter core,$(MODULES)),)
    # リストの中に X が【含まれている】場合の処理
    $(error [FATAL ERROR] MODULESの中に 'core' が含まれています。ビルドを強制終了します。)
endif

ifeq ($(filter omzt-%,$(MODULES)),)
    $(error [FATAL ERROR] omzテーマモジュール(omzt-*)が必要です。 ビルドを強制終了します。)
endif

$(OUT_DIR)/$(CONFIG_DIR)/omz.d:
	@mkdir -p $@
	@cp -r $(SRC_DIR)/omz/ohmyzsh/* $@

$(OUT_DIR)/$(OMZ_PLUGINS_FILE): $(OMZ_PLUGINS_FILES)
	@mkdir -p $(dir $@)
	@echo "# ------------------------------------------------------------------------------" > $@
	@echo "# OhMyZsh plugins" >> $@
	@echo "# ------------------------------------------------------------------------------" >> $@
# 【重要】plugins結合ルール
# ()の中にスペース区切りでプラグイン名を書く
	@cat $^ | awk 'BEGIN{printf "plugins=( "} $$0 !~ /^#/{printf $$0" "} END{print ")"}' >> $@
