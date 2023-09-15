#!/bin/bash

directories=(
    "quark"
    "shim"
    "vmm/sandbox"
    "vmm/task"
    "wasm"
)

for dir in "${directories[@]}"; do
    (cd "$dir" && cargo vendor)
done