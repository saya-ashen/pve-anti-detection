# 增加Proxmox 的源文件
source /etc/os-release
echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
# 增加 ceph 源文件 换源
echo "deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription" > /etc/apt/sources.list.d/ceph.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 1140AF8F639E0C39
sudo apt-get update
sudo apt-get install libacl1-dev libaio-dev libattr1-dev libcap-ng-dev libcurl4-gnutls-dev libepoxy-dev libfdt-dev libgbm-dev libglusterfs-dev libgnutls28-dev libiscsi-dev libjpeg-dev libnuma-dev libpci-dev libpixman-1-dev libproxmox-backup-qemu0-dev librbd-dev libsdl1.2-dev libseccomp-dev libslirp-dev libspice-protocol-dev libspice-server-dev libsystemd-dev liburing-dev libusb-1.0-0-dev libusbredirparser-dev libvirglrenderer-dev meson python3-sphinx python3-sphinx-rtd-theme quilt xfslibs-dev
ls
git clone git://git.proxmox.com/git/pve-qemu.git
cd pve-qemu
apt install devscripts -y
mk-build-deps --install -y
make
: <<'EOF'
make clean
cp ../sedPatch-pve-qemu-kvm7-8-anti-dection.sh qemu/
cp ../smbios.h qemu/include/hw/firmware/smbios.h
cp ../smbios.c qemu/hw/smbios/smbios.c
cd qemu
chmod +x sedPatch-pve-qemu-kvm7-8-anti-dection.sh
bash sedPatch-pve-qemu-kvm7-8-anti-dection.sh
cd ..
apt install devscripts -y
mk-build-deps --install -y
make 
EOF
