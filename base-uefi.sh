#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc

echo "nl_BE.UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8" >> /etc/locale.gen

locale-gen

echo "LANG=nl_BE.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "archie" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archie.localdomain archie" >> /etc/hosts
echo root:ss8800ss | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S --noconfirm networkmanager vim nano cups cups-pdf xorg xorg-xinit xterm alacritty firefox firefox-i18n-nl thunderbird thunderbird-i18n-nl gnome grub efibootmgr os-prober dosfstools mtools ntfs-3g network-manager-applet dialog alsa-utils pulseaudio bash-completion openssh virt-manager qemu qemu-arch-extra flatpak terminus-font cantarell-fonts bspwm sxhkd budgie-desktop filezilla bluefish sqlitebrowser cmake python-virtualenv python-pip git htop

# pacman -S --noconfirm xf86-video-amdgpu
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#sstemctl enable reflector.timer
#systemctl enable fstrim.timer
systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid
systemctl enable gdm.service

groupadd serge
useradd -m -g serge -G libvirt audio video -s /bin/bash serge
echo serge:ss8800ss | chpasswd
mkdir -p /home/serge/data
chown serge:serge /home/serge/data

echo 'UUID=1d0ea00f-82cf-47e9-ac37-e02161a7a65e /home/serge/data auto nosuid,nodev,nofail,x-gvfs-show 0 0' >> /etc/fstab

echo "serge ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/10-nopasswd-serge


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




