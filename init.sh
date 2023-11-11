########################################

FOR POST DISK PARTITION WILL

########################################
nix-shell -p git | sudo git clone https://github.com/HermitsA/nix-astolfo.git & exit
sudo nixos-generate-config --root /mnt
sudo cp nix-astolfo/nixos /mnt/etc/
nix-shell -p git | sudo git clone https://github.com/HermitsA/nix-astolfo.git /mnt/nix-astolfo & exit
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-unstable
sudo nix-channel --update










