#!/bin/bash

cd ~ || exit

wget -O - https://apt.llvm.org/llvm.sh > llvm.sh
sudo chmod +x llvm.sh
sudo ./llvm.sh 17 all
sudo ./llvm.sh all
rm llvm.sh

insights_path="$HOME/insights"

# Check if build exists
if [ ! -d "$insights_path" ]; then
    mkdir "$insights_path"
fi

cd "$insights_path" || exit

git clone https://github.com/andreasfertig/cppinsights.git
mkdir build
cd build || exit

cmake \
    -G"Ninja" \
    ../cppinsights \
    -DLLVM_CONFIG_PATH=/usr/lib/llvm-17/bin//llvm-config \
    || exit

ninja
