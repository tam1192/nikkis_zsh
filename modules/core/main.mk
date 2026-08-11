MOD_CORE     := core
MOD_CORE_DIR := $(MODULES_DIR)/$(MOD_CORE)
MOD_CORE_MAIN := $(MOD_CORE_DIR)/src/main.sh 

ifeq ($(SHELL_TYPE), zsh)
	MOD_CORE_MAIN += $(MOD_CORE_DIR)/src/main.zsh 
endif

# 必須
$(MOD_CORE_DIR)/main.sh: $(MOD_CORE_MAIN)
	@cat $^ > $@

# 必須
$(MOD_CORE_DIR)/main.var:
	@touch $@

# 必須
$(MOD_CORE_DIR)/main.env:
	@touch $@

# 必須
.PHONY: core-clean
core-clean: $(MOD_CORE_DIR)/main.sh $(MOD_CORE_DIR)/main.var $(MOD_CORE_DIR)/main.env
	@rm $^