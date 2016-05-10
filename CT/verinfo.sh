#!/bin/sh

echo "System Information:"
uname -a
echo
echo "lspci:"
lspci
echo
echo "CPU Info:"
cat /proc/cpuinfo
echo
echo "Banner:"
cat /etc/banner
echo
echo "Network Devices:"
ip addr show
echo
echo "Routing information:"
ip route show
echo
echo "Qdisc information:"
tc qdisc show
echo
echo "WiFi Information:"
if [ -f /sys/class/net/wlan0/address ]
then
	iw dev wlan0 info
fi
if [ -f /sys/class/net/wlan1/address ]
then
        iw dev wlan1 info
fi

echo
echo "dmesg output:"
dmesg

echo
echo "Board Info:"
cat /etc/board.json
