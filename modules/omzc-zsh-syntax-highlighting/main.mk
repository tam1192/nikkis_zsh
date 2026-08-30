# ==============================================================================
# Module: Omzc Zsh Syntax Highlighting
# ==============================================================================

MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING        := omzc-zsh-syntax-highlighting
MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR    := $(MODULES_DIR)/$(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING)
# omzcのディレクトリの下に展開する
MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_OUTDIR := $(MOD_OMZC_OUTDIR)/plugins/zsh-syntax-highlighting

# 依存関係: omz必須
ifeq ($(filter omzc,$(MODULES)),)
    $(error [FATAL ERROR] omzcモジュールが必要です。 ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR)/main.sh: $(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_OUTDIR)
	@> $@

# モジュール用追加ディレクトリ
$(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_OUTDIR): $(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR)/zsh-syntax-highlighting
	@cp -r $< $@

$(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: omzc-zsh-syntax-highlighting-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
omzc-zsh-syntax-highlighting-clean:
	@rm -f $(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR)/main.sh $(MOD_OMZC_ZSH_SYNTAX_HIGHLIGHTING_DIR)/main.env
