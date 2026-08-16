# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
OMZ_PLUGINS_FILE  := $(CONFIG_DIR)/omz_plugins.zsh
OMZ_PLUGINS_FILES := $(patsubst %,$(BUILD_DIR)/%.omzp,$(filter omz%,$(MODULES)))

ALLS += $(OUT_DIR)/$(OMZ_PLUGINS_FILE)

# ------------------------------------------------------------------------------
# Validation / Guard Clause
# ------------------------------------------------------------------------------
ifneq ($(filter core,$(MODULES)),)
    $(error [FATAL ERROR] MODULESの中に 'core' が含まれています。ビルドを強制終了します。)
endif

ifeq ($(filter omzt-%,$(MODULES)),)
    $(error [FATAL ERROR] omzテーマモジュール(omzt-*)が必要です。ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Rules
# ------------------------------------------------------------------------------
$(BUILD_DIR)/omz.main: $(BUILD_DIR)/omz/main.zsh
	@cp $^ $@

$(BUILD_DIR)/omz.omzp: $(BUILD_DIR)/omz/omzp.zsh
	@cp $^ $@

$(BUILD_DIR)/omz.alias:
	@touch $@

$(BUILD_DIR)/omz.path:
	@touch $@

$(OUT_DIR)/$(CONFIG_DIR)/omz.d:
	@mkdir -p $@
	@cp -r $(SRC_DIR)/omz/ohmyzsh/* $@