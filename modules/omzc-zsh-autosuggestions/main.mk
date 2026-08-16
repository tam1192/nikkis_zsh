# ==============================================================================
# Module: Omzc Zsh Autosuggestions
# ==============================================================================

MOD_OMZC_ZSH_AUTOSUGGESTIONS        := omzc-zsh-autosuggestions
MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR    := $(MODULES_DIR)/$(MOD_OMZC_ZSH_AUTOSUGGESTIONS)
# omzcのディレクトリの下に展開する
MOD_OMZC_ZSH_AUTOSUGGESTIONS_OUTDIR := $(MOD_OMZC_OUTDIR)/plugins/zsh-autosuggestions

# 依存関係: omz必須
ifeq ($(filter omzc,$(MODULES)),)
    $(error [FATAL ERROR] omzcモジュールが必要です。 ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR)/main.sh: $(MOD_OMZC_ZSH_AUTOSUGGESTIONS_OUTDIR)
	@> $@

# モジュール用追加ディレクトリ
$(MOD_OMZC_ZSH_AUTOSUGGESTIONS_OUTDIR): $(MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR)/zsh-autosuggestions
	@cp -r $< $@

$(MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzc-zsh-autosuggestions-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzc-zsh-autosuggestions-clean:
	@rm -f $(MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR)/main.sh $(MOD_OMZC_ZSH_AUTOSUGGESTIONS_DIR)/main.env
