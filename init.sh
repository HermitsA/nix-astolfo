########################################
#                                      #
#FOR POST DISK PARTITION WILL          #
#                                      #
########################################
nix-shell -p git | sudo git clone https://github.com/HermitsA/nix-astolfo.git & exit
sudo nixos-generate-config --root /mnt
sudo cp nix-astolfo/nixos /mnt/etc/
nix-shell -p git | sudo git clone https://github.com/HermitsA/nix-astolfo.git /mnt/nix-astolfo & exit
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=8000000
sudo mkswap /mnt/.swapfile
swapon /mnt/.swapfile
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-unstable
sudo nix-channel --update
nixos-install








