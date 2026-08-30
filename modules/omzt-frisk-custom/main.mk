# ==============================================================================
# Module: Omzt Frisk Custom
# ==============================================================================

MOD_OMZT_FRISK_CUSTOM        := omzt-frisk-custom
MOD_OMZT_FRISK_CUSTOM_DIR    := $(MODULES_DIR)/$(MOD_OMZT_FRISK_CUSTOM)
MOD_OMZT_FRISK_CUSTOM_OUTDIR := $(MOD_OMZC_OUTDIR)/themes/frisk.zsh-theme

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'omzt-frisk-custom' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

$(BUILD_DIR)/omzt-frisk-custom.omzp:
	@touch $@

ifneq ($(filter-out omzt-frisk-custom,$(filter omzt-%,$(MODULES))),)
    $(error [FATAL ERROR] 他のomzテーマモジュールを含んでいます。 ビルドを強制終了します。)
endif

ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 存在しない必須ファイルを生成
$(MOD_OMZT_FRISK_CUSTOM_DIR)/main.sh: $(MOD_OMZT_FRISK_CUSTOM_DIR)/src/main.zsh $(MOD_OMZT_FRISK_CUSTOM_OUTDIR)
	@cat $< > $@

$(MOD_OMZT_FRISK_CUSTOM_DIR)/main.env:
	@> $@

# モジュール用追加ディレクトリ
$(MOD_OMZT_FRISK_CUSTOM_OUTDIR): $(MOD_OMZT_FRISK_CUSTOM_DIR)/src/frisk.zsh-theme
	@cp $< $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzt-frisk-custom-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzt-frisk-custom-clean:
	@rm -f $(MOD_OMZT_FRISK_CUSTOM_DIR)/main.sh $(MOD_OMZT_FRISK_CUSTOM_DIR)/main.env
