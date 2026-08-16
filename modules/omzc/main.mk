# ==============================================================================
# Module: Omzc
# ==============================================================================

MOD_OMZC        := omzc
MOD_OMZC_DIR    := $(MODULES_DIR)/$(MOD_OMZC)
MOD_OMZC_OUTDIR := $(OUT_DIR)/$(SHELL_DIR)/$(MOD_OMZC)

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'MOD_OMZC' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

# 依存関係: omz必須
ifeq ($(filter omz,$(MODULES)),)
    $(error [FATAL ERROR] omzモジュールが必要です。 ビルドを強制終了します。)
endif

OLI_ARGS += -o ZSH_CUSTOM

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_OMZC_DIR)/main.sh: $(MOD_OMZC_OUTDIR)
	@> $@

# モジュール用追加ディレクトリ
$(MOD_OMZC_OUTDIR): $(MOD_OMZC_DIR)/src/zsh_custom
	@cp -r $< $@

$(MOD_OMZC_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzc-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzc-clean:
	@rm -f $(MOD_OMZC_DIR)/main.sh $(MOD_OMZC_DIR)/main.env
