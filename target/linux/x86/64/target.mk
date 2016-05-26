ARCH:=x86_64
BOARDNAME:=x86_64
DEFAULT_PACKAGES += kmod-button-hotplug kmod-e1000e kmod-e1000 kmod-r8169 kmod-igb
DEFAULT_PACKAGES += kmod-8139cp kmod-8139too
DEFAULT_PACKAGES += kmod-i2c-core kmod-i2c-algo-bit
# Add some drivers for common wifi NICs
DEFAULT_PACKAGES += kmod-ath9k kmod-ath10k kmod-ath9k-htc kmod-ath5k
# Add some firmware
DEFAULT_PACKAGES += ath10k-firmware-qca988x ath10k-firmware-qca99x0 ath9k-htc-firmware ath10k-firmware-qca6174
# Useful general OS packages
DEFAULT_PACKAGES += bzip2 curl dmesg ethtool getopt hostapd ip-full iperf3 iputils-ping iputils-tracepath iw
DEFAULT_PACKAGES += nstat relayd tcpdump wpa-cli wpa-supplicant wpa-supplicant-mesh

define Target/Description
        Build images for 64 bit systems including virtualized guests.
endef
