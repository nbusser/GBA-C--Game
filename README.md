# C/C++ GBA Bazel Base

Forked from https://github.com/depp/bazel-gba-example/tree/main.

This is an example project for building a Game Boy Advance C/C++ game with Bazel.

## Building

Requires Bazel 8.3.1. You do not have to install devKitARM, Bazel will download it automatically.

```shell
make build
```

## Running

Requires mgba. I wish in the future to build mgba from the repo directly.

```shell
make run
```

## Clangd

The repo is configured to use `clangd`.

To generate the compile commands file, you can run:

```shell
make compile-commands.json
```

You can easily regenerate the file and build at the same time with:
```shell
make build-dev
```
