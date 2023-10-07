#!/bin/bash

set -e  # Exit on any error

gh release create ${{ env.RELEASE_VERSION }} --generate-notes

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

mkdir ../temp
cp -r ./* ../temp/
tar -czvf ${{ env.VENDOR_NAME }} -C ../temp .
gh release upload ${{ env.RELEASE_VERSION }} ${{ env.VENDOR_NAME }}
