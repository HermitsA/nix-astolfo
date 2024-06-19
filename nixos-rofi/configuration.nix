# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ inputs, config, lib, pkgs, ... }:
{


#funny astolfo neofetch

environment.interactiveShellInit = ''
alias neofetch='neofetch --kitty --size 35% --source /astolfos/Imgs\&Ascii/astolfochibi.png';
alias confs='sudo nano /etc/nixos/configuration.nix';
alias nixy='sudo nixos-rebuild switch --upgrade-all';
'';

#enable flakes and unfree
nixpkgs.config.allowUnfree = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
experimental-features = [ "nix-command" "flakes" ];   
};
system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";


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
#  boot.initrd.kernelModules = ["nvidia"];
 # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];




# Hostname
  networking.hostName = "rider"; # Define your hostname.


  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
   time.timeZone = "Europe/Amsterdam";


# Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
services.desktopManager.plasma6.enable = true;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [

    # Add any missing dynamic libraries for unpackaged programs

    # here, NOT in environment.systemPackages

  ];


# environment.plasma5.excludePackages = with pkgs.libsForQt5; [
# elisa
#  gwenview
#  okular
#  oxygen
#  khelpcenter
#  konsole
#  plasma-browser-integration
#  print-manager
#];

#kdePackages.kdenlive.enable = true;

virtualisation.waydroid.enable = true;

#flatpak support!

virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;



services.flatpak.enable = true;
services.xserver.enable = true;
hardware = {
	opengl.enable = true;
	opengl.driSupport = true;
	opengl.driSupport32Bit = true;
#	nvidia.modesetting.enable = true;
};

#hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
#	hardware.nvidia = {
#	powerManagement.enable = true;
#	open = false;
#	nvidiaSettings = true;
#};

services.displayManager.sddm = {

enable = true;

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      #autoLogin.enable = true;
#autoLogin.user = "astolfo";

#theme = "${import ./kek.nix { inherit pkgs; }}"; 

settings = {
  Autologin = {
    Session = "hyprland";
    User = "astolfo";
  };
};


wayland.enable = true;

};




services.xserver.videoDrivers =["amd"];

programs.hyprland = {
	enable = true;
	portalPackage = pkgs.xdg-desktop-portal-hyprland;
	xwayland.enable = true;
};
	environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";
	NIXOS_OZONE_WL = "1";
};
#xdg.portal.enable = true;
xdg.autostart.enable = true;
xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; }; 
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
(pkgs.discord-ptb.override {
  withVencord = true;
})
catppuccin-sddm-corners
pamixer
discover
wget
nano
librewolf
doas
neofetch
kitty
temurin-bin-21
#mpv
#wf-recorder
swappy
#wine
#rpcs3
#vinegar

#libunwind-dev libglfw3-dev libvulkan-dev vulkan-validationlayers-dev spirv-tools glslang-tools libspirv-cross-c-shared-dev libsox-dev 
git
wl-clipboard
cmake
nwg-displays
slurp
wireplumber
discord-ptb
swww
#lutris
obs-studio
qbittorrent
dolphin
htop
steam
rofi
neofetch
#bottles
libsForQt5.qt5ct
libsForQt5.qt5.qtsvg
libsForQt5.qt5.qtgraphicaleffects
libsForQt5.qt5.qtquickcontrols
wlr-randr
mangohud
#webcord-vencord
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


#ist packages installed in system profile. To search, run:
  # $ nix search wget
environment.variables.EDITOR = "nano";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
# List services that you want to enable:
# Enable the OpenSSH daemon.
   services.openssh.enable = true;


# Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
networking.interfaces.eno1.wakeOnLan.enable = true;
# Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
# This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
system.stateVersion = "23.11";


home-manager.users.astolfo = 

{config, pkgs, ...}: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland = (import flake-compat {
    src = builtins.fetchGit  {
      url = "https://github.com/hyprwm/Hyprland.git";
      submodules = true;
    };
  }).defaultNix;
in {
  imports = [
    hyprland.homeManagerModules.default
  ];

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


programs.rofi.enable = true;
programs.rofi.theme = /run/current-system/sw/share/rofi/themes/purple.rasi;


wayland.windowManager.hyprland = {
enable = true;
extraConfig = "


exec-once = swww query || swww init
exec-once = swww img /astolfos/Imgs\&Ascii/astolfo.png
exec-once = waybar
exec-once = export MOZ_ENABLE_WAYLAND=1
exec-once = export XDG_CURRENT_DESKTOP=Hyprland
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = steam
exec-once = librewolf
#my monitorconfig

#monitor=DP-2,2560x1440@59.951,0x0,1.0
#monitor=HDMI-A-1,2560x1440@59.951,1680x0,1.0
#monitor=DP-1,1920x1200@59.953999,4240x390,1.0

monitor=DP-2,2560x1440@74.779999,0x0,1.0
monitor=DP-3,1920x1200@59.950001,5120x240,1.0
monitor=HDMI-A-1,2560x1440@59.951,2560x0,1.0



$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, kitty
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, D, exec, discordptb 
bind = $mainMod SHIFT, S, exec, bash /astolfos/screenshot 

bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bind = $mainMod SHIFT, right, resizeactive, 10 0
bind = $mainMod SHIFT, left, resizeactive, -10 0
bind = $mainMod SHIFT, up, resizeactive, 0 -10
bind = $mainMod SHIFT, down, resizeactive, 0 10
bindm = $mainMod, mouse:273, resizewindow


";
};

home.stateVersion = "23.11";
};
}
