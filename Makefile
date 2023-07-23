TEMPLATE?=goimports.html.tmpl
DEFAULT_ENV?=default.env
BUILD_DIR?=.tmp
ENV_DIR?=values
OUT_DIR?=docs

MAKE_DIRS=$(BUILD_DIR) $(OUT_DIR)
CLEAN_FILES=$(BUILD_DIR) $(OUT_DIR)/*.html

VALUES=$(wildcard $(ENV_DIR)/*.env)
HTMLS=${subst $(ENV_DIR),$(OUT_DIR),$(VALUES:.env=.html)}

.PHONY: all mkdirs docs clean

mkdirs:
	mkdir -p $(MAKE_DIRS)

$(BUILD_DIR)/%.env: $(ENV_DIR)/%.env $(DEFAULT_ENV) mkdirs
	$(shell cat $(DEFAULT_ENV)) envsubst < $< > $@

$(OUT_DIR)/%.html: $(BUILD_DIR)/%.env $(DEFAULT_ENV) mkdirs
	$(shell cat $(DEFAULT_ENV) $<) envsubst < $(TEMPLATE) > $@

docs: $(HTMLS)

all: docs

clean:
	rm -rvf $(CLEAN_FILES)
