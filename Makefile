# ==============================================================================
# nikkis zsh - Root Makefile
# ==============================================================================

MAKEFLAGS += -r

# モジュール
MODULES := basic vim omz omzc omzt-frisk-custom omzc-zsh-autosuggestions omzc-zsh-syntax-highlighting macos mesugaki 

# allルール
all: rc

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
# 子ファイルと共通で使う出力ディレクトリ
OUT_DIR     := out
SHELL_DIR   := .config/shell
MODULES_DIR := modules

# ビルドスクリプト・オプション設定
SCRIPTS     := scripts
OLI         := $(SCRIPTS)/oneline_initializer/oli.sh
OLI_ARGS    := -s PATH :
TAGCAT      := $(SCRIPTS)/tagcat/tagcat.sh
TAGCAT_ARGS := "\#\#\#\#\#\#\#\#\#\#" -h "\#" -h "\# filename: \$$FILE" -h "\#" -h "\#\#\#\#\#\#\#\#\#\#"
SWAP		:= $(SCRIPTS)/swap.sh

# ターゲットシェルの指定（デフォルト: zsh）
SHELL_TYPE  ?= zsh

ifeq ($(SHELL_TYPE), zsh)
    RC := .zshrc
else ifeq ($(SHELL_TYPE), bash)
    RC := .bashrc
else
    $(error [ERROR] 非対応シェル '$(SHELL_TYPE)' です。ビルドを強制終了します。)
endif

# ------------------------------------------------------------------------------
# Include Module Rules
# ------------------------------------------------------------------------------
include $(patsubst %,$(MODULES_DIR)/%/main.mk,$(MODULES))

# ------------------------------------------------------------------------------
# Targets & Phonies
# ------------------------------------------------------------------------------
.PHONY: all rc clean

# 基本ルール
rc: $(OUT_DIR)/$(RC)

clean:
	@rm -rf $(OUT_DIR)
	@$(MAKE) $(patsubst %,%-clean,$(MODULES))

check:
# SC2148(shebang)の警告を排除
	shellcheck --version
	@shellcheck -s bash -e SC2148 $$(git ls-files '*.zsh')
	@shellcheck -e SC2148 $$(git ls-files '*.sh')

fmt-check:
	shfmt --version
	@shfmt -d $$(git ls-files '*.zsh')
	@shfmt -d $$(git ls-files '*.sh')

fmt:
	@shfmt -w -ln=auto $$(git ls-files '*.zsh')
	@shfmt -w $$(git ls-files '*.sh')

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------
# 出力ディレクトリ作成
$(OUT_DIR) $(OUT_DIR)/$(SHELL_DIR):
	@mkdir -p $@

# RCファイル生成
# 環境変数 -> 変数 -> mainの順で読み込み
$(OUT_DIR)/$(RC): $(OUT_DIR)/$(SHELL_DIR) \
                  $(OUT_DIR)/$(SHELL_DIR)/main.cat.sh \
                  $(OUT_DIR)/$(SHELL_DIR)/vars.sh \
                  $(OUT_DIR)/$(SHELL_DIR)/envs.sh
	@{ \
		echo "shell_dir=\"\$$HOME/$(SHELL_DIR)\""; \
		echo "source \"\$$shell_dir/envs.sh\""; \
		echo "source \"\$$shell_dir/vars.sh\""; \
		echo "source \"\$$shell_dir/main.cat.sh\""; \
	} > $@

# mainの集約
$(OUT_DIR)/$(SHELL_DIR)/main.cat.sh: $(patsubst %,$(MODULES_DIR)/%/main.sh,$(MODULES))
	@$(TAGCAT) $(TAGCAT_ARGS) $^ > $@

# varの集約
$(OUT_DIR)/$(SHELL_DIR)/vars.sh: $(patsubst %,$(MODULES_DIR)/%/main.var,$(MODULES))
	@cat $^ | $(OLI) $(OLI_ARGS) > $@

# envの集約
$(OUT_DIR)/$(SHELL_DIR)/envs.sh: $(patsubst %,$(MODULES_DIR)/%/main.env,$(MODULES))
	@cat $^ | $(OLI) -e $(OLI_ARGS) > $@

# zcompileルール
%.zsh.zwc: %.zsh
	@zsh -c 'zcompile $<'

# ------------------------------------------------------------------------------
# Install Rules
# ------------------------------------------------------------------------------
BACKUP_DIR  := backup
BACKUP_NAME := $(BACKUP_DIR)/$(shell date +%Y%m%d%H%M%S.shbak.d)

.PHONY: all install

all: install

# BACKUP_NAME が空の場合は依存関係が空になり、そのまま通過する
install: $(HOME)/$(RC) $(HOME)/$(SHELL_DIR)

# 実際のバックアップファイルを生成するルール
$(BACKUP_NAME).tar.gz:
	tar -czvf "$@" 

$(BACKUP_NAME):
	mkdir -p $@

$(HOME)/$(RC): $(OUT_DIR)/$(RC) $(BACKUP_NAME)
	-mv $@ $(BACKUP_NAME)
	cp $< $@

$(HOME)/$(SHELL_DIR): $(OUT_DIR)/$(SHELL_DIR) $(BACKUP_NAME)
	-mv $@ $(BACKUP_NAME)
	cp -r $< $@
