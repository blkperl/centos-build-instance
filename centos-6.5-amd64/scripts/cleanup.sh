yum -y clean all

# Remove traces of mac address from network configuration
sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
rm /etc/udev/rules.d/70-persistent-net.rules

# Empty out log files, but don't delete them
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Clean out some other folders
rm -rf /var/tmp/*

# Zero out the free space to save space in the final image:
cat /dev/zero > zero.fill;sync;sleep 1;sync;rm -f zero.fill

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
