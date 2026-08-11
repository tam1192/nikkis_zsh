# ==============================================================================
# Module: Core
# ==============================================================================

MOD_CORE      := core
MOD_CORE_DIR  := $(MODULES_DIR)/$(MOD_CORE)
MOD_CORE_MAIN := $(MOD_CORE_DIR)/src/main.sh

ifeq ($(SHELL_TYPE), zsh)
    MOD_CORE_MAIN += $(MOD_CORE_DIR)/src/main.zsh
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_CORE_DIR)/main.sh: $(MOD_CORE_MAIN)
	@cat $^ > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_CORE_DIR)/main.var:
	@> $@

$(MOD_CORE_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: core-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
core-clean:
	@rm -f $(MOD_CORE_DIR)/main.sh $(MOD_CORE_DIR)/main.var $(MOD_CORE_DIR)/main.env