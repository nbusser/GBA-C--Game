#!/bin/bash

# Good-enough workaround for clangd issue on custom toolchain.

compiler_path=$(bazel query --output=location @devkitarm//:bin/arm-none-eabi-gcc | cut -d ":" -f1)

cat > $(dirname "$(realpath $0)")/../../.clangd << EOF
CompileFlags:
  Compiler: "$compiler_path"
  Remove:
    - -mthumb-interwork
EOF
