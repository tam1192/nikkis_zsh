# ------------------------------------------------------------------------------
# nikkis zsh - Root Makefile
# ------------------------------------------------------------------------------

MAKEFLAGS += -r

# 出力ディレクトリ
OUT_DIR := build
SRC_DIR := src

# 導入するモジュール
MODULE := core basic vim
ALIAS_FILE := $(patsubst %, $(OUT_DIR)/%.alias, $(MODULE))
MAIN_FILE := $(patsubst %, $(OUT_DIR)/%.main, $(MODULE))
PATH_FILE := $(patsubst %, $(OUT_DIR)/%.path, $(MODULE))

# 動的に環境情報を取得 (動的切り替え用、または静的ビルドの判定用)
OS_TYPE := $(shell uname -s | tr '[:upper:]' '[:lower:]')
DISTRO  := $(shell [ -f /etc/os-release ] && grep -i '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"' || echo "unknown")

# include
include $(patsubst %, $(SRC_DIR)/%/main.mk, $(MODULE))

.PHONY: all install

all: zshrc
install: all
	# TODO


$(OUT_DIR)/%: $(SRC_DIR)/%
	@mkdir -p $(dir $@)
	@echo "# ------------------------------------------------------------------------------" > $@
	@echo "# ( $* )" >> $@
	@echo "# module: $(word 1,$(subst /, ,$*))" >> $@
	@echo "# file  : $(notdir $*)" >> $@
	@echo "# ------------------------------------------------------------------------------" >> $@
	@cat $^ >> $@
	@echo >> $@
$(OUT_DIR)/alias.zsh: $(ALIAS_FILE)
	@cat $^ > $@

$(OUT_DIR)/main.zsh: $(MAIN_FILE)
	@cat $^ > $@

$(OUT_DIR)/path.zsh: $(PATH_FILE)
	@echo "# ------------------------------------------------------------------------------" > $@
	@echo "# PATH" >> $@
	@echo "# ------------------------------------------------------------------------------" >> $@
	@cat $^ | awk 'BEGIN{printf "PATH="} $$0 ~ /^\//{printf $$0":"} END{print "$$PATH"}' >> $@

zshrc: $(OUT_DIR)/main.zsh $(OUT_DIR)/alias.zsh $(OUT_DIR)/path.zsh
	@cat $^ > $@

