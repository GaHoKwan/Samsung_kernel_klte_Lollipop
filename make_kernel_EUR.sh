#!/bin/bash
# MSM8974PRO KK kernel build script

mkdir -p bin
mkdir -p $(pwd)/output
ln -sf /usr/bin/python2.7 ./bin/python
export PATH=$(pwd)/bin:$PATH

BUILD_KERNEL_DIR=$(pwd)
KERNEL_DEFCONFIG=msm8974_sec_defconfig
DEBUG_DEFCONFIG=msm8974_sec_userdebug_defconfig
SELINUX_DEFCONFIG=selinux_defconfig
SELINUX_LOG_DEFCONFIG=selinux_log_defconfig
VARIANT_DEFCONFIG=msm8974pro_sec_klte_eur_defconfig
BUILD_KERNEL_OUT_DIR=$(pwd)/output
BUILD_CROSS_COMPILE=/home/jay/kernel/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

make -C $BUILD_KERNEL_DIR O=$BUILD_KERNEL_OUT_DIR -j$BUILD_JOB_NUMBER ARCH=arm \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE \
			$KERNEL_DEFCONFIG VARIANT_DEFCONFIG=$VARIANT_DEFCONFIG \
			SELINUX_DEFCONFIG=$SELINUX_DEFCONFIG DEBUG_DEFCONFIG=$DEBUG_DEFCONFIG
#			SELINUX_LOG_DEFCONFIG=$SELINUX_LOG_DEFCONFIG
			

make -C $BUILD_KERNEL_DIR O=$BUILD_KERNEL_OUT_DIR -j$BUILD_JOB_NUMBER ARCH=arm \
			CROSS_COMPILE=$BUILD_CROSS_COMPILE

tools_pack/dtbToolCM -2 -o $BUILD_KERNEL_OUT_DIR/arch/arm/boot/dt.img -s 2048 -p $BUILD_KERNEL_OUT_DIR/scripts/dtc/ $BUILD_KERNEL_OUT_DIR/arch/arm/boot/

read anykey
