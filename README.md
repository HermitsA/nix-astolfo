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

sudo -i

**check devices**

lsblk 

**choose which device you want**\

**for nvme devices its /dev/nvme**\ 

**for sata devices its /dev/sda** \

**choose which install you want, in this guide its gonna be nvme for bare metal**\


**Partitioning your device:**

cfdisk /dev/nvme0n1\

d

n

enter

enter

+1024Mib

enter

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

**get git clone**


nix-shell -p git 
git clone https://github.com/HermtisA/nix-astolfo.git

exit

**thing**

cd nix-astolfo

sudo sh init.sh

**done!!!**

sudo reboot


# Post install

gaming!
