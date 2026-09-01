# ==============================================================================
# Module: Secretive
# ==============================================================================

MOD_SECRETIVE      := secretive
MOD_SECRETIVE_DIR  := $(MODULES_DIR)/$(MOD_SECRETIVE)
MOD_SECRETIVE_SOCK := $(HOME)/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh


# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------

# 必須: main.sh の生成
$(MOD_SECRETIVE_DIR)/main.sh: $(MOD_SECRETIVE_SOCK)
	@echo "export SSH_AUTH_SOCK=$(MOD_SECRETIVE_SOCK)" > $@

# 必須: 空ファイルの初期化 (touch ではなく > $@ にすることでクリアを保証)
$(MOD_SECRETIVE_DIR)/main.var:
	@> $@

$(MOD_SECRETIVE_DIR)/main.env:
	@> $@

# ------------------------------------------------------------------------------
# Phonies & Clean
# ------------------------------------------------------------------------------
.PHONY: secretive-clean

# 必須: クリーン処理 (存在しないファイルがあってもエラーにならないよう -f を付与)
secretive-clean:
	@rm -f $(MOD_SECRETIVE_DIR)/main.sh $(MOD_SECRETIVE_DIR)/main.var $(MOD_SECRETIVE_DIR)/main.env