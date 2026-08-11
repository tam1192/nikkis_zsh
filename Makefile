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
MODULES := basic vim omz omzc omzc-zsh-autosuggestions omzt-robbyrussell

# 各モジュールごとの生成ファイルパス
ALIAS_FILES := $(patsubst %,$(BUILD_DIR)/%.alias,$(MODULES))
MAIN_FILES  := $(patsubst %,$(BUILD_DIR)/%.main,$(MODULES))
PATH_FILES  := $(patsubst %,$(BUILD_DIR)/%.path,$(MODULES))
EXT_DIRS    := $(patsubst %,$(OUT_DIR)/$(CONFIG_DIR)/%.d,$(MODULES))

SCRIPTS     := scripts
OLI         := $(SCRIPTS)/oli.sh
OLI_ARGS    := "-s PATH :" 
TAGCAT      := $(SCRIPTS)/tagcat.sh
TAGCAT_ARGS := "\# filename: $$FILE"

# ------------------------------------------------------------------------------
# Environment Detection (環境情報の取得)
# ------------------------------------------------------------------------------
OS_TYPE := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DISTRO  := $(shell [ -f /etc/os-release ] && sed -n 's/^ID=\(?*[^"]*\)?*/\1/p' /etc/os-release || echo "unknown")

ALLS := $(OUT_DIR)/$(ZSHRC_FILE) $(OUT_DIR)/$(MAIN_FILE).zwc $(OUT_DIR)/$(ALIAS_FILE).zwc $(OUT_DIR)/$(PATH_FILE) $(EXT_DIRS)



# ------------------------------------------------------------------------------
# Phony Targets
# ------------------------------------------------------------------------------
.PHONY: all install clean


all: hall

# ------------------------------------------------------------------------------
# Includes
# ------------------------------------------------------------------------------
-include $(patsubst %,$(SRC_DIR)/%/main.mk,$(MODULES))

hall: $(ALLS)

install: all
	@echo "Installing..."
	# TODO: インストール処理をここに記述

clean:
	@rm -rf $(BUILD_DIR) $(TARGETS) $(OUT_DIR)
	@mkdir -p $(BUILD_DIR) $(OUT_DIR)
	@touch $(BUILD_DIR)/.gitkeep $(OUT_DIR)/.gitkeep
	@echo "Cleaned up build artifacts."



# ------------------------------------------------------------------------------
# Build Rules
# ------------------------------------------------------------------------------
# 最終成果物の生成
$(OUT_DIR)/$(ZSHRC_FILE): 
	@touch $@
	@echo 'export SHELL_CONFIG=$$HOME/$(CONFIG_DIR)' >> $@
	@echo 'source $$HOME/$(ALIAS_FILE)' >> $@
	@echo 'source $$HOME/$(MAIN_FILE)' >> $@
	@echo 'source $$HOME/$(PATH_FILE)' >> $@
	@echo "Successfully generated $@ !"

# 各コンポーネントの結合
$(OUT_DIR)/$(ALIAS_FILE): $(ALIAS_FILES)
	@mkdir -p $(dir $@)
	@cat $^ > $@

$(OUT_DIR)/$(MAIN_FILE): $(MAIN_FILES)
	@mkdir -p $(dir $@)
	@cat $^ > $@

$(OUT_DIR)/$(PATH_FILE): $(PATH_FILES)
	

# 中間ファイルの生成ルール (パターンルール)
$(BUILD_DIR)/%: $(SRC_DIR)/%
	@mkdir -p $(dir $@)
	@$(FMT_HEADER_SCRIPT) $^gst "module" $(firstword $(subst /, ,$*)) > $@

# varファイルルール
%.sh: %.var
	$(OLI) $(OLI_ARGS)

# envファイルルール
%.sh: %.env
	$(OLI) -e $(OLI_ARGS)

# zcompileルール
%.zsh.zwc: %.zsh
	@zsh -c 'zcompile $<'
