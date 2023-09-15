#!/bin/bash

sudo gh release create ${{ env.RELEASE_VERSION }} --generate-notes

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

sudo mkdir ../temp
sudo cp -r ./* ../temp/
sudo tar -czvf ${{ env.VENDOR_NAME }} -C ../temp .
sudo gh release upload ${{ env.RELEASE_VERSION }} ${{ env.VENDOR_NAME }}