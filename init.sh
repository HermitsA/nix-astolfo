nixos-generate-config --root /mnt:
sudo cp -r nixos /mnt/etc:
sudo cp -r astolfos /mnt:
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=8000000:
sudo mkswap /mnt/.swapfile:
swapon /mnt/.swapfile
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager:
sudo nix-channel --add https://nixos.org/channels/nixos-unstable:
sudo nix-channel --update:
nixos-install:
cp nixos-rofi/* /mnt/etc/nixos/:

echo type reboot if you want to go into the normal thing.







