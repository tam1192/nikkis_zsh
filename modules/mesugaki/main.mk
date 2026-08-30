# ==============================================================================
# Module: Mesugaki
# ==============================================================================

MOD_MESUGAKI      := mesugaki
MOD_MESUGAKI_DIR  := $(MODULES_DIR)/$(MOD_MESUGAKI)
MOD_MESUGAKI_MAIN := $(MOD_MESUGAKI_DIR)/src/main.zsh

ifneq ($(SHELL_TYPE), zsh)
	# zsh のみ対応
	$(error [FATAL ERROR] お兄さんまだZsh採用してないの〜？ざぁこざぁこ)
endif

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_MESUGAKI_DIR)/main.sh: $(MOD_MESUGAKI_MAIN)
	@cat $^ > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_MESUGAKI_DIR)/main.var:
	@> $@

$(MOD_MESUGAKI_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: mesugaki-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
mesugaki-clean:
	@rm -f $(MOD_MESUGAKI_DIR)/main.sh $(MOD_MESUGAKI_DIR)/main.var $(MOD_MESUGAKI_DIR)/main.env