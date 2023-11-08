Release 14 november? maybe
funny nix configs about astolfo
hyprland rice
Learned nix/HM for this

![1699121802-wayshot](https://github.com/HermitsA/nix-astolfo/assets/149957167/0fbf0c2e-8464-416a-80d2-60243922a20e)

Astolfo OS current progress (non flake configs)

Flake/Home-manager overheal soon 

Timeline rn: \
standard nix env (done!) -> Flake / Home-manager overhaul -> Install script - Release


# Current install guide for nixos 
"
sudo -i

#check devices
lsblk 
 **choose which device you want**\
**for nvme devices its /dev/nvme**\ 
**for sata devices its /dev/sda** \
**choose which install you want, in this guide its gonna be nvme for bare metal**\


**Partitioning your device:**

cfdisk /dev/nvme0n1

d
n
enter
enter
+1024Mib
t
1
n
enter
enter
enter
w

**filesystems**

mkfs.fat -F 32 /dev/nvme0n1p1

fatlabel /dev/nvme0n1p1 NIXBOOT

mkfs.ext4 /dev/nvme0n1p2 -L NIXROOT


mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

cd /mnt

**make swapfile**
dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=8000000

mkswap .swapfile

swapon


**get git clone**


nix-shell -p git
git clone https://github.com/HermtisA/nix-astolfo.git

exit

**nixos unstable/HM install**

sudo sh nix-astolfo/scripts/nix-unstable.sh \
sudo sh nix-astolfo/scripts/home-manager.sh

**copy nixos config**
cp nix-astolfo/nixos/* /mnt/etc/

cd /mnt/etc/nixos

**install nixos**
nixos-install

sudo reboot


# Post install

gaming!
