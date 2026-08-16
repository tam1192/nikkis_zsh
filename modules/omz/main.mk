# ==============================================================================
# Module: Omz
# ==============================================================================

MOD_OMZ        := omz
MOD_OMZ_DIR    := $(MODULES_DIR)/$(MOD_OMZ)
MOD_OMZ_MAIN   := $(MOD_OMZ_DIR)/src/main.zsh
MOD_OMZ_OUTDIR := $(OUT_DIR)/$(SHELL_DIR)/$(MOD_OMZ)

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'omz' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

ifneq ($(filter core,$(MODULES)),)
    # リストの中に X が【含まれている】場合の処理
    $(error [FATAL ERROR] MODULESの中に 'core' が含まれています。ビルドを強制終了します。)
endif

ifeq ($(filter omzt-%,$(MODULES)),)
    $(error [FATAL ERROR] omzテーマモジュール(omzt-*)が必要です。 ビルドを強制終了します。)
endif

OLI_ARGS += -o ZSH -o ZSH_THEME -o plugins

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_OMZ_DIR)/main.sh: $(MOD_OMZ_MAIN) $(MOD_OMZ_OUTDIR)
	@cp $< $@

# モジュール用追加ディレクトリ
$(MOD_OMZ_OUTDIR): $(MOD_OMZ_DIR)/src/ohmyzsh
	@cp -r $< $@

$(MOD_OMZ_DIR)/src/ohmyzsh: 
	@git submodule update --init --recursive

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omz-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omz-clean:
	@true
