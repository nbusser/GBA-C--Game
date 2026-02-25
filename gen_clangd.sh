#!/bin/bash

# Horrible workaround for clangd issues.
# TODO: find something cleaner
cat > .clangd << EOF
CompileFlags:
  Compiler: "$(bazel info output_base)/external/+_repo_rules+devkitarm/bin/arm-none-eabi-gcc"
  Remove:
    - -mthumb-interwork
EOF
