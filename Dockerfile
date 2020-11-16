# sshd and qemu on archlinux
#
# VERSION               0.0.1

FROM	 archlinux:latest
MAINTAINER antonidas42o #HOMOGANG

# Update the repositories
RUN	 pacman -Syy

# Install openssh
RUN	 pacman -Sy --noconfirm openssh systemd-sysvcompat base qemu qemu-arch-extra qemu-block-gluster qemu-block-iscsi qemu-block-rbd qemu-guest-agent ovmf libvirt libvirt-glib libvirt-python nano vim neofetch socklog-void 

# Generate host keys
RUN  /usr/bin/ssh-keygen -A

# Add password to root user
RUN echo "root:123allerlei?" | chpasswd

# Fix sshd
RUN  sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN  sed -i -e 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Expose tcp port
EXPOSE 22 3333 5800 5900

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ “/sys/fs/cgroup” ]

# Run openssh daemon
CMD	 ["/sbin/init"]