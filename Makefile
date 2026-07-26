# ==============================================================================
# nikkis zsh - Root Makefile
# ==============================================================================

MAKEFLAGS += -r

# ------------------------------------------------------------------------------
# Configuration (変数の設定)
# ------------------------------------------------------------------------------
# 子ファイルと共通で使う出力ディレクトリ (変更不可)
# OUT_DIR: homeディレクトリの想定
OUT_DIR   := out
BUILD_DIR := build
SRC_DIR   := src

# 出力後のディレクトリ
CONFIG_DIR := .config/shell
ALIAS_FILE := $(CONFIG_DIR)/alias.zsh
MAIN_FILE  := $(CONFIG_DIR)/main.zsh
PATH_FILE  := $(CONFIG_DIR)/path.zsh
ZSHRC_FILE := .zshrc

# 導入するモジュール
MODULES := core basic vim

# 各モジュールごとの生成ファイルパス
ALIAS_FILES := $(patsubst %,$(BUILD_DIR)/%.alias,$(MODULES))
MAIN_FILES  := $(patsubst %,$(BUILD_DIR)/%.main,$(MODULES))
PATH_FILES  := $(patsubst %,$(BUILD_DIR)/%.path,$(MODULES))
EXT_DIRS    := $(patsubst %,$(OUT_DIR)/$(CONFIG_DIR)/%.d,$(MODULES))

# ------------------------------------------------------------------------------
# Environment Detection (環境情報の取得)
# ------------------------------------------------------------------------------
OS_TYPE := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DISTRO  := $(shell [ -f /etc/os-release ] && sed -n 's/^ID=\(?*[^"]*\)?*/\1/p' /etc/os-release || echo "unknown")

# ------------------------------------------------------------------------------
# Phony Targets
# ------------------------------------------------------------------------------
.PHONY: all install clean

all: $(OUT_DIR)/$(ZSHRC_FILE) $(OUT_DIR)/$(MAIN_FILE) $(OUT_DIR)/$(ALIAS_FILE) $(OUT_DIR)/$(PATH_FILE) $(EXT_DIRS)

install: all
	@echo "Installing..."
	# TODO: インストール処理をここに記述

clean:
	@rm -rf $(BUILD_DIR) $(TARGETS) $(OUT_DIR)
	@mkdir -p $(BUILD_DIR) $(OUT_DIR)
	@touch $(BUILD_DIR)/.gitkeep $(OUT_DIR)/.gitkeep
	@echo "Cleaned up build artifacts."

# ------------------------------------------------------------------------------
# Includes
# ------------------------------------------------------------------------------
-include $(patsubst %,$(SRC_DIR)/%/main.mk,$(MODULES))

# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------
# 最終成果物の生成
$(OUT_DIR)/$(ZSHRC_FILE): 
	@echo "Successfully generated $@ !"

# 各コンポーネントの結合
$(OUT_DIR)/$(ALIAS_FILE): $(ALIAS_FILES)
	@mkdir -p $(dir $@)
	@cat $^ > $@

$(OUT_DIR)/$(MAIN_FILE): $(MAIN_FILES)
	@mkdir -p $(dir $@)
	@cat $^ > $@

$(OUT_DIR)/$(PATH_FILE): $(PATH_FILES)
	@mkdir -p $(dir $@)
	@echo "# ------------------------------------------------------------------------------" > $@
	@echo "# PATH" >> $@
	@echo "# ------------------------------------------------------------------------------" >> $@
# 【重要】PATH結合ルール
# 入力ファイル (*.path) は「/aaa/bbb」のようなフルパスが改行区切りで記述されている想定。
# 1. 最初のみ「PATH=」を出力
# 2. スラッシュから始まる行（有効な絶対パス）をコロン「:」区切りで順次結合
# 3. 最後に既存の環境変数「$$PATH」を連結して安全性を担保する
	@cat $^ | awk 'BEGIN{printf "PATH="} $$0 ~ /^\//{printf $$0":"} END{print "$$PATH"}' >> $@

# 中間ファイルの生成ルール (パターンルール)
$(BUILD_DIR)/%: $(SRC_DIR)/%
	@mkdir -p $(dir $@)
	@printf '# %s\n' \
		"------------------------------------------------------------------------------" \
		"( $* )" \
		"module: $(firstword $(subst /, ,$*))" \
		"file  : $(notdir $*)" \
		"------------------------------------------------------------------------------" > $@
	@cat $< >> $@
	@echo "" >> $@