# ==============================================================================
# Module: Basic
# ==============================================================================

MOD_BASIC      := basic
MOD_BASIC_DIR  := $(MODULES_DIR)/$(MOD_BASIC)
MOD_BASIC_MAIN := $(MOD_BASIC_DIR)/src/main.sh $(MOD_BASIC_DIR)/src/alias.sh

ifeq ($(SHELL_TYPE), zsh)
    MOD_BASIC_MAIN += $(MOD_BASIC_DIR)/src/alias.zsh
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_BASIC_DIR)/main.sh: $(MOD_BASIC_MAIN)
	@cat $^ > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_BASIC_DIR)/main.var:
	@> $@

$(MOD_BASIC_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: basic-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
basic-clean:
	@rm -f $(MOD_BASIC_DIR)/main.sh $(MOD_BASIC_DIR)/main.var $(MOD_BASIC_DIR)/main.env