.PHONY: build compile-commands.json build-dev run basic-clean clean super-clean

BAZEL = bazel
QUERY = //src:game
MGBA = mgba

DEPS_DIR := deps
DEVKITARM_STAMP := $(DEPS_DIR)/installed/devkitarm-crtls-1.2.6-1/.stamp
LIBGBA_STAMP := $(DEPS_DIR)/installed/libgba-0.5.4-1/.stamp

$(DEVKITARM_STAMP):
	mkdir -p $(DEPS_DIR)/installed
	tmpdir=$$(mktemp -d) && \
	tar --zstd -xf $(DEPS_DIR)/tarballs/devkitarm-crtls-1.2.6-1-any.pkg.tar.zst -C "$$tmpdir" >/dev/null && \
	mv "$$tmpdir/opt/devkitpro/devkitARM/arm-none-eabi/lib" $(DEPS_DIR)/installed/devkitarm-crtls-1.2.6-1 && \
	rm -rf "$$tmpdir"
	touch $(DEVKITARM_STAMP)

$(LIBGBA_STAMP):
	mkdir -p $(DEPS_DIR)/installed
	tmpdir=$$(mktemp -d) && \
	tar --zstd -xf $(DEPS_DIR)/tarballs/libgba-0.5.4-1-any.pkg.tar.zst -C "$$tmpdir" >/dev/null && \
	mv "$$tmpdir/opt/devkitpro/libgba" $(DEPS_DIR)/installed/libgba-0.5.4-1 && \
	rm -rf "$$tmpdir"
	touch $(LIBGBA_STAMP)

# Installs dependencies that cannot be fetched form bazel.
setup: $(DEVKITARM_STAMP) $(LIBGBA_STAMP)

build: setup
	$(BAZEL) build --config=gba --config=strict "$(QUERY)"

compile-commands.json:
	$(BAZEL) run --config=host --config=strict //tools/generate_compile_commands -- "//src:game"

build-dev: compile-commands.json build

# TODO: build mgba via bazel
run:
	$(MGBA) bazel-bin/src/game.gba

basic-clean:
	rm -rf deps/installed
	rm -f compile_commands.json

clean: basic-clean
	$(BAZEL) clean

super-clean: basic-clean
	$(BAZEL) clean --expunge
