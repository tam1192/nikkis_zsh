# ==============================================================================
# Module: Omz
# ==============================================================================

MOD_OMZ        := omz
MOD_OMZ_DIR    := $(MODULES_DIR)/$(MOD_OMZ)
MOD_OMZ_MAIN   := $(MOD_OMZ_DIR)/src/main.sh
MOD_OMZ_OUTDIR := $(OUT_DIR)/$(SHELL_DIR)/$(MOD_OMZ)

ifeq ($(SHELL_TYPE), zsh)
    MOD_OMZ_MAIN += $(MOD_OMZ_DIR)/src/main.zsh
endif

ifneq ($(filter omz,$(MODULES)),)
    # リストの中に X が【含まれている】場合の処理
    $(error [FATAL ERROR] MODULESの中に 'omz' が含まれています。ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_OMZ_DIR)/main.sh: $(MOD_OMZ_MAIN) $(MOD_OMZ_OUTDIR)
	@cat $< > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_OMZ_DIR)/main.var:
	@> $@

$(MOD_OMZ_DIR)/main.env:
	@> $@

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
	@rm -f $(MOD_OMZ_DIR)/main.sh $(MOD_OMZ_DIR)/main.var $(MOD_OMZ_DIR)/main.env
