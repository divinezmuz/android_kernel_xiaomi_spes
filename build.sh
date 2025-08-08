#!/bin/bash

# Create a new log file or clear existing one
> kernel_build.log

{
    echo "[i] Build started at $(date -u +'%Y-%m-%d %H:%M:%S') UTC"

    echo "[+] Cleaning build directory..."
    make clean mrproper O=out

    echo "[+] Generating defconfig..."
    make O=out ARCH=arm64 LLVM=1 vendor/spes-perf_defconfig

    echo "[+] Building the kernel..."
    make -j$(nproc) O=out ARCH=arm64 LLVM=1 Image.gz dtbo.img

    echo "[i] Build ended at $(date -u +'%Y-%m-%d %H:%M:%S') UTC"

} 2>&1 | tee -a kernel_build.log
