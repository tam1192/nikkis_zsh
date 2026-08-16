# ==============================================================================
# Module: OmztRobbyrussell
# ==============================================================================

MOD_OMZT_ROBBYRUSSEL        := omzt-robbyrussell
MOD_OMZT_ROBBYRUSSEL_DIR    := $(MODULES_DIR)/$(MOD_OMZT_ROBBYRUSSEL)

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'omzt-robbyrussell' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

$(BUILD_DIR)/omzt-robbyrussell.omzp:
	@touch $@

ifneq ($(filter-out omzt-robbyrussell,$(filter omzt-%,$(MODULES))),)
    $(error [FATAL ERROR] 他のomzテーマモジュールを含んでいます。 ビルドを強制終了します。)
endif

ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 存在しない必須ファイルを生成
$(MOD_OMZT_ROBBYRUSSEL_DIR)/main.sh:
	@> $@

$(MOD_OMZT_ROBBYRUSSEL_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzt-robbyrussell-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzt-robbyrussell-clean:
	@rm -f $(MOD_OMZT_ROBBYRUSSEL_DIR)/main.sh $(MOD_OMZT_ROBBYRUSSEL_DIR)/main.env
