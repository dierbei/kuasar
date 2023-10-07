#!/bin/bash

sudo curl -LJO https://github.com/containerd/containerd/releases/download/v1.7.0/containerd-1.7.0-linux-amd64.tar.gz
sudo mkdir bin && tar -C bin -xzvf containerd-1.7.0-linux-amd64.tar.gz

sudo cat > bin/config.toml <<EOF
version = 2

[plugins."io.containerd.grpc.v1.cri"]
disable_apparmor = true

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.vmm]
runtime_type = "io.containerd.kuasar.v1"
sandboxer = "vmm"
io_type = "hvsock"

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.quark]
runtime_type = "io.containerd.quark.v1"
sandboxer = "quark"

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.wasm]
runtime_type = "io.containerd.wasm.v1"
sandboxer = "wasm"

[proxy_plugins.vmm]
type = "sandbox"
address = "/run/vmm-sandboxer.sock"

[proxy_plugins.quark]
type = "sandbox"
address = "/run/quark-sandboxer.sock"

[proxy_plugins.wasm]
type = "sandbox"
address = "/run/wasm-sandboxer.sock"
EOF

sudo echo "config.toml has been created!"
