#!/bin/bash

sudo gh release create $RELEASE_VERSION --generate-notes

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
sudo tar -czvf $VENDOR_NAME -C ../temp .
sudo gh release upload $RELEASE_VERSION $VENDOR_NAME