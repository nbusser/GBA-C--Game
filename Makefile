.PHONY: build dev-setup compile_commands.json build-dev run basic-clean clean super-clean

BAZEL = bazel
QUERY = //src:game

DEPS_DIR := deps

build:
	$(BAZEL) build --config=gba --config=strict "$(QUERY)"

dev-setup:
	./gen_clangd.sh

compile_commands.json: dev-setup
	$(BAZEL) run --config=host //tools/generate_compile_commands -- \
		"$(QUERY)" --extra_aquery_arg=--config=gba

build-dev: build compile_commands.json

run:
	$(BAZEL) run --config=gba --config=strict //tools/mgba:run_rom

basic-clean:
	rm -f compile_commands.json

clean: basic-clean
	$(BAZEL) clean

super-clean: basic-clean
	$(BAZEL) clean --expunge
	rm -rf external
	rm -rf .cache
	rm -rf bazel-*
