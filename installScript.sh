#Retrived from:
#https://www.raspberrypi.com/documentation/computers/linux_kernel.html
#TODO: include lto for each build for link time optimization
# Build configuration

set -e

if [[ $EUID -ne 0 ]]; then
	echo "Run with sudo!!"
	exit 1
fi



cd linux;
KERNEL=kernel_2712;
make ARCH=arm64 bcm2712_defconfig;


CONFIG_LOCALVERSION="-v8-16k-EmuStation-Kernel";

#build for ARM64
make -j6 Image.gz modules dtbs;


#kernel installation
make -j6 modules_install



# To install the 64-bit kernel:
#note This is old and from rpi's documentation. cd into /boot
#and use the readme's location of the kernel stuff that it wants. 
#rpi wants /boot/firmware/*
#dietpi wants /boot/*



cp /boot/firmware/$KERNEL.img /boot/firmware/$KERNEL-backup.img
#sudo cp /boot/$KERNEL.img /boot/$KERNEL-backup.img

cp arch/arm64/boot/Image.gz /boot/firmware/$KERNEL.img
#sudo cp arch/arm64/boot/Image.gz /boot/$KERNEL.img



cp arch/arm64/boot/dts/broadcom/*.dtb /boot/firmware/
#sudo cp arch/arm64/boot/dts/broadcom/*.dtb /boot


cp arch/arm64/boot/dts/overlays/*.dtb* /boot/firmware/overlays/
#sudo cp arch/arm64/boot/dts/overlays/*.dtb* /boot/overlays/



cp arch/arm64/boot/dts/overlays/README /boot/firmware/overlays/
#sudo cp arch/arm64/boot/dts/overlays/README /boot/overlays/

