# ==============================================================================
# Module: HomeBrew
# ==============================================================================

MOD_BREW      := brew
MOD_BREW_DIR  := $(MODULES_DIR)/$(MOD_BREW)
MOD_BREW_MAIN := $(MOD_BREW_DIR)/src/main.sh 

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] MODULES 'brew' はSHELL_TYPE 'zsh' 以外対応していません。ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_BREW_DIR)/main.sh: $(MOD_BREW_MAIN)
	@cat $^ > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_BREW_DIR)/main.var:
	@> $@

$(MOD_BREW_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: brew-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
brew-clean:
	@rm -f $(MOD_BREW_DIR)/main.sh $(MOD_BREW_DIR)/main.var $(MOD_BREW_DIR)/main.env