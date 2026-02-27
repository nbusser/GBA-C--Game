#!/bin/bash

# Queries bazel to find the absolute compiler path and creates .clangd file accordingly.

compiler_path=$(bazel query --output=location @devkitarm//:bin/arm-none-eabi-gcc | cut -d ":" -f1)

cat > $(dirname "$(realpath $0)")/../../.clangd << EOF
CompileFlags:
  Compiler: "$compiler_path"
  Remove:
    - -mthumb-interwork
EOF
