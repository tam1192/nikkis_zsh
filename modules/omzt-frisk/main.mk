# ==============================================================================
# Module: Omzt Frisk
# ==============================================================================

MOD_OMZT_FRISK        := omzt-frisk
MOD_OMZT_FRISK_DIR    := $(MODULES_DIR)/$(MOD_OMZT_FRISK)

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'omzt-frisk' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

$(BUILD_DIR)/omzt-frisk.omzp:
	@touch $@

ifneq ($(filter-out omzt-frisk,$(filter omzt-%,$(MODULES))),)
    $(error [FATAL ERROR] 他のomzテーマモジュールを含んでいます。 ビルドを強制終了します。)
endif

ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 存在しない必須ファイルを生成
$(MOD_OMZT_FRISK_DIR)/main.sh:
	@> $@

$(MOD_OMZT_FRISK_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzt-frisk-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzt-frisk-clean:
	@rm -f $(MOD_OMZT_FRISK_DIR)/main.sh $(MOD_OMZT_FRISK_DIR)/main.env
