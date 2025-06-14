# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ inputs, config, lib, pkgs, ... }:
{

environment.interactiveShellInit = ''
alias neofetch='neofetch --kitty --size 35% --source /astolfos/content/astolfochibi.png';
alias confs='sudo nano /etc/nixos/configuration.nix';
alias nixy='sudo nixos-rebuild switch --upgrade-all';
'';

#              nixpkgs.config.permittedInsecurePackages = [
 #               "dotnet-sdk-7.0.410"
  #            ];

#enable flakes and unfree
nixpkgs.config.allowUnfree = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
experimental-features = [ "nix-command" "flakes" ];   
};

system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};

nixpkgs.config.packageOverrides = pkgs: {  
ciscoPacketTracer8 = pkgs.callPackage /home/astolfo/projects/package.nix {};

  steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        pango
        libthai
        harfbuzz
      ];
    };
  };


imports =
    [ 
      ./hardware-configuration.nix
	#<home-manager/nixos>
	 (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
];


#optimize storage
nix.optimise.automatic = true;
nix.settings.auto-optimise-store = true;

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};

  # Use the systemd-boot EFI boot loader.
# Boot configurations & enable nvidia support & latest kernel

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["amdgpu"];
#  boot.kernelModules = ["vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"]; 

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];

# Hostname
  networking.hostName = "rider"; # Define your hostname.


  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
   time.timeZone = "Europe/Amsterdam";

 programs.steam.enable = true; 

services.desktopManager.plasma6.enable = true;

virtualisation.waydroid.enable = true;

#flatpak support!



qt.enable = true;
qt.platformTheme = "kde";

virtualisation = {

docker = {
enable = true;
};


libvirtd = {
enable = true;
qemu = {
		swtpm.enable = true;
		ovmf.enable = true;
		ovmf.packages = [ pkgs.OVMFFull.fd ];
			};
		};
	};
services.flatpak.enable = true;
services.xserver.enable = true;
services.xserver.videoDrivers = [ "amdgpu" ];
hardware = {
	graphics = {
#	extraPackages = [
  #  pkgs.amdvlk
 # ];
  #extraPackages32 = [
   # pkgs.driversi686Linux.amdvlk
  #];
		enable = true;
		enable32Bit = true;
		};
};
# environment.variables.VK_ICD_FILENAMES =
 #   "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
 #environment.variables.VK_ICD_FILENAMES =
#    "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";

services.displayManager.sddm = {

enable = true;
wayland.enable = true;

};

security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
};
 users.users.astolfo = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" ];
	initialPassword = "astolfo"; 
};

  environment.systemPackages = with pkgs; [
(pkgs.discord-ptb.override { withVencord = true; })

(ciscoPacketTracer8.overrideAttrs { dontCheckForBrokenSymlinks = true; })

(pkgs.bottles.override { removeWarningPopup = true;} )



#vscode-fhs
gpu-screen-recorder
gpu-screen-recorder-gtk

#dotnetCorePackages.dotned_8.sdk
#dotnet-sdk_7

gradle


winePackages.unstableFull

#shadps4
  #libimobiledevice
 # ifuse
r2modman


#steamcmd
corectrl

 (prismlauncher.override {
    # Add binary required by some mod
    additionalPrograms = [ ffmpeg mangohud];
    gamemodeSupport = true;
    # Change Java runtimes available to Prism Launcher
    jdks = [
temurin-jre-bin
temurin-bin-24
graalvm-ce
graalvm-oracle
zulu8
openjdk8-bootstrap
temurin-jre-bin-8
temurin-jre-bin
zulu

    ];
  })


bottles
curlFull
#gnutls

protontricks
winetricks




#sc-controller
#gamescope
kdePackages.kdenlive
vesktop
#papirus-icon-theme
waybar
unrar
catppuccin-sddm-corners
pamixer
#discover
wget
nano
librewolf
#doas
neofetch
steam-run
tree
kitty
fuse
#sweethome3d.application
#fuse2
temurin-bin-21
swappy
git
#nordic
wl-clipboard
cmake
#nwg-displays
slurp
filezilla
#lutris
wireplumber
discord-ptb

anki-bin
ciscoPacketTracer8

#krita
swww
obs-studio
qbittorrent
fuzzel
kdePackages.dolphin
htop
#steam
appimage-run
fuse
#rofi
virt-manager
starship

heroic-unwrapped

#virt-viewer
#win-virtio
adwaita-icon-theme
neofetch
#bottles
libsForQt5.qt5ct
libsForQt5.qt5.qtsvg
libsForQt5.qt5.qtgraphicaleffects
libsForQt5.qt5.qtquickcontrols
wlr-randr
mangohud
#webcord-vencord
pciutils
#stress
#libsForQt5.discover
#libsForQt5.packagekit-qt
#qt6-wayland
libportal-qt5
grim
prismlauncher
protonup-qt
#distrobox
#sensors
#podman 
 ];


environment.variables.EDITOR = "nano";
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
   services.openssh.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };


   networking.firewall.enable = false;
networking.interfaces.eno1.wakeOnLan.enable = true;
system.stateVersion = "24.11";


home-manager.users.astolfo = 

{config, inputs, pkgs, ...}: {

  programs.librewolf = {
    enable = true;
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = true;
       "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;

    };
  };







programs.kitty = {
enable = true;
theme = "Wild Cherry";
extraConfig = " 
font_family      jetbrains mono nerd font
font_size 20
bold_font        auto
italic_font      auto
bold_italic_font auto
mouse_hide_wait  2.0
cursor_shape     block
url_color        #0087bd
url_style        dotted
Close the terminal without confirmation
confirm_os_window_close 0
background_opacity 0.80
";

}; 


dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};


home.stateVersion = "23.11";
};
}
