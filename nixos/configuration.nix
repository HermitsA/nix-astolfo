# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ inputs, config, lib, pkgs, ... }:
{


#funny astolfo neofetch

environment.interactiveShellInit = ''
alias neofetch='neofetch --kitty --size 35% --source /astolfos/content/astolfochibi.png';
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
  boot.initrd.kernelModules = ["vfio_pci" "vfio_iommu_type1" "vfio"];
#  boot.kernelModules = ["vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"]; 
# boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.kernelParams = [
"amd_iommu=on"
"vfio-pci.ids=1002:164e"
];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-amd" ];




# Hostname
  networking.hostName = "rider"; # Define your hostname.


  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
   time.timeZone = "Europe/Amsterdam";


services.desktopManager.plasma6.enable = true;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [

  ];



virtualisation.waydroid.enable = true;

#flatpak support!

virtualisation = {

    

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
hardware = {
	graphics = {
		enable = true;
		enable32Bit = true;
		};
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

wayland.enable = true;

};




fonts.packages = with pkgs; [
material-design-icons
hack-font
noto-fonts-cjk-serif
noto-fonts-cjk-sans
noto-fonts-emoji
noto-fonts-extra
nerdfonts
fira-code
fira
fira-mono
fira-code-nerdfont
fira-code-symbols
inter
fantasque-sans-mono
noto-fonts 
jetbrains-mono
cascadia-code
comfortaa
icomoon-feather
iosevka
source-code-pro
];


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
papirus-icon-theme
waybar
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
swappy
git
nordic
wl-clipboard
cmake
nwg-displays
slurp
wireplumber
discord-ptb
swww
obs-studio
qbittorrent
fuzzel
dolphin
htop
steam
appimage-run
fuse
rofi
virt-manager
starship

virt-viewer
win-virtio
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


   networking.firewall.enable = false;
networking.interfaces.eno1.wakeOnLan.enable = true;
system.stateVersion = "23.11";


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





home.file = { 
".config/fuzzel/fuzzel.ini" = {
text = ''

dpi-aware=no
width=12.5
font=Hack:weight=bold:size=15
line-height=25
fields=name,generic,comment,categories,filename,keywords
terminal=foot -e
prompt="❯   " 
layer=overlay
[colors]
background=282a36fa
selection=3d4474fa
border=fffffffa

[border]
radius=5

[dmenu]
exit-immediately-if-empty=yes

''; 
executable = false; };
};

home.file = { 
"./screenshot" = {
text = ''
grim -g "$(slurp)" - | swappy -f -
''; 
executable = true; };
};

home.file = { 
".config/waybar/config.jsonc" = {
text = ''
{
  "layer": "top",
  "position": "top",
  "height": 30,
  "spacing": 0,
  "margin-top": 8,
  "margin-left": 0,
  "margin-right": 0,
  "modules-left": ["hyprland/workspaces", "custom/dnd"],
  "modules-center": ["custom/spotify"],
  "modules-right": [
    "pulseaudio",
    "cpu",
    "memory",
    "disk",
    "temperature",
    "backlight",
    "keyboard-state",
    "sway/language",
    "battery",
    "battery#bat2",
    "clock",
    "tray"
  ],
  "keyboard-state": {
    "numlock": true,
    "capslock": true,
    "format": "{name} {icon}",
    "format-icons": {
      "locked": "",
      "unlocked": ""
    }
  },
  "hyprland/workspaces": {
    "on-click": "activate",
    "sort-by-number": true
  },
  "sway/mode": {
    "format": "<span style=\"italic\">{}</span>"
  },
  "sway/scratchpad": {
    "format": "{icon} {count}",
    "show-empty": false,
    "format-icons": ["", ""],
    "tooltip": true,
    "tooltip-format": "{app}: {title}"
  },
  "mpd": {
    "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
    "format-disconnected": "Disconnected ",
    "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
    "unknown-tag": "N/A",
    "interval": 2,
    "consume-icons": {
      "on": " "
    },
    "random-icons": {
      "off": "<span color=\"#f53c3c\"></span> ",
      "on": " "
    },
    "repeat-icons": {
      "on": " "
    },
    "single-icons": {
      "on": "1 "
    },
    "state-icons": {
      "paused": "",
      "playing": ""
    },
    "tooltip-format": "MPD (connected)",
    "tooltip-format-disconnected": "MPD (disconnected)"
  },
  "idle_inhibitor": {
    "format": "{icon}",
    "format-icons": {
      "activated": "",
      "deactivated": ""
    }
  },
  "tray": {
    // "icon-size": 60,
    "spacing": 15
  },
  "clock": {
    // "timezone": "Europe/Paris",
    "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
    "format-alt": "{:%Y-%m-%d}"
  },
  "cpu": {
    "format": "{usage}% ",
    "tooltip": false
  },
  "memory": {
    "format": "{}% "
  },
  "temperature": {
    // "thermal-zone": 2,
    // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
    "critical-threshold": 80,
    // "format-critical": "{temperatureC}°C {icon}",
    "format": "{temperatureC}°C {icon}",
    "format-icons": [""],
    "tooltip": false
  },
  "backlight": {
    // "device": "acpi_video1",
    "format": "{percent}% {icon}",
    "format-icons": ["", "", "", "", "", "", "", "", ""],
    "tooltip": false
  },
  "battery": {
    "states": {
      // "good": 95,
      "warning": 30,
      "critical": 15
    },
    "format": "{capacity}% {icon} ",
    "format-charging": "{capacity}% 󱐋",
    "format-plugged": "{capacity}% ",
    "format-alt": "{time} {icon}",
    // "format-good": "", // An empty format will hide the module
    // "format-full": "",
    "format-icons": ["", "", "", "", ""],
    "tooltip": false
  },
  "battery#bat2": {
    "bat": "BAT2"
  },
  "network": {
    // "interface": "wlp2*", // (Optional) To force the use of this interface
    "format-wifi": "{essid} ({signalStrength}%) ",
    "format-ethernet": "{ipaddr}/{cidr} ",
    "tooltip-format": "{ifname} via {gwaddr} ",
    "format-linked": "{ifname} (No IP) ",
    "format-disconnected": "Disconnected ⚠",
    "format-alt": "{ifname}: {ipaddr}/{cidr}"
  },
  "pulseaudio": {
    // "scroll-step": 1, // %, can be a float
    "format": "{volume}% {icon}",
    "format-bluetooth": "{volume}% ",
    "format-bluetooth-muted": "󰂲",
    "format-muted": "󰝟",
    // "format-source": "{volume}% ",
    // "format-source-muted": "",
    "format-icons": {
      "headphone": "",
      "hands-free": "",
      "headset": "",
      "phone": "",
      "portable": "",
      "car": "",
      "default": ["", "", ""]
    },
    "on-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
    "tooltip": false
  },
  "custom/spotify": {
    "exec": "playerctl -p spotify -a metadata --format '{\"text\": \"{{markup_escape(trunc(artist, 30))}} - {{markup_escape(trunc(title, 30))}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F",
    "format": "  {}",
    "return-type": "json",
    "on-click": "playerctl -p spotify play-pause",
    "on-double-click": "playerctl -p spotify next",
    "on-triple-click": "playerctl -p spotify previous && playerctl -p spotify previous",
    "on-scroll-up": "hyprctl dispatch focuswindow Spotify",
    "tooltip": false
  },
  "disk": {
    "interval": 30,
    "format": "{percentage_free}% 󰨣"
  },
  "custom/dnd": {
    "interval": "once",
    "return-type": "json",
    "format": "{}{icon}",
    "format-icons": {
      "default": "",
      "dnd": " "
    },
    "on-click": "makoctl mode | grep 'do-not-disturb' && makoctl mode -r do-not-disturb || makoctl mode -a do-not-disturb; pkill -RTMIN+11 waybar",
    "on-click-right": "makoctl restore",
    "exec": "printf '{\"alt\":\"%s\",\"tooltip\":\"mode: %s\"}' $(makoctl mode | grep -q 'do-not-disturb' && echo dnd || echo default) $(makoctl mode | tail -1)",
    "signal": 11
  }
}

''; 
executable = false; };
};

home.file = { 
".config/waybar/style.css" = {
text = ''
* {
  /* `otf-font-awesome` is required to be installed for icons */
  font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
  font-size: 21px;
}

window#waybar {
  background-color: rgba(43, 48, 59, 0);
  border-bottom: 3px solid rgba(100, 114, 125, 0);
  color: #ffffff;
  transition-property: background-color;
  transition-duration: 0.5s;
  padding: 0;
  margin: 0;
}
button {
  /* Use box-shadow instead of border so the text isn't offset */
  box-shadow: inset 0 -3px transparent;
  /* Avoid rounded borders under each button name */
  border: none;
  border-radius: 0;
}

/* workspaces widget is kinda egoist */
#workspaces {
  background: #332e41;
  border-radius: 30px;
  margin: 0px 10px;
}

#workspaces button.active {
  background: #4f64c4;
  border-radius: 30px;
}

#workspaces button.urgent {
  background-color: #eb4d4b;
  border-radius: inherit;
}

#workspaces button:hover {
  background: #af81f0;
  border-radius: inherit;
}

/* General settings for all widgets */
#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#tray,
#mode,
#custom-spotify,
#idle_inhibitor,
#scratchpad,
#custom-spotify,
#custom-dnd,
#mpd {
  padding: 0px 20px;
  margin: 0;
  color: #d4d5d9;
  background-color: #332e41;
}

/* Settings for groups */
#custom-dnd,
#pulseaudio,
#custom-spotify {
  margin: 0px 10px;
  border-radius: 30px;
}

#battery.critical:not(.charging) {
  background-color: #f53c3c;
  color: #ffffff;
}

label:focus {
  background-color: #000000;
}

#cpu {
  border-radius: 30px 0px 0px 30px;
}

#custom-media {
  background-color: #66cc99;
  color: #2a5c45;
  min-width: 200px;
}

#custom-media.custom-spotify {
  background-color: #66cc99;
}

#custom-media.custom-vlc {
  background-color: #ffa000;
}

#temperature.critical {
  background-color: #eb4d4b;
}

#tray {
  border-radius: 0px 30px 30px 0px;
}

#tray > .passive {
  -gtk-icon-effect: dim;
}

#tray > .needs-attention {
  -gtk-icon-effect: highlight;
  background-color: #eb4d4b;
}

#idle_inhibitor {
  background-color: #2d3436;
}

#idle_inhibitor.activated {
  background-color: #ecf0f1;
  color: #2d3436;
}

#mpd {
  background-color: #66cc99;
  color: #2a5c45;
}

#mpd.disconnected {
  background-color: #f53c3c;
}

#mpd.stopped {
  background-color: #90b1b1;
}

#mpd.paused {
  background-color: #51a37a;
}

#language {
  background: #00b093;
  color: #740864;
  padding: 0 10px;
  margin: 0 10px;
  min-width: 32px;
}

#keyboard-state {
  background: #97e1ad;
  color: #000000;
  padding: 0 0px;
  margin: 0 10px;
  min-width: 32px;
}

#keyboard-state > label {
  padding: 0 10px;
}

#keyboard-state > label.locked {
  background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
  background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
  background-color: transparent;
}

''; 
executable = false; };
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






wayland.windowManager.hyprland = {

enable = true;
extraConfig = "
env = NIXOS_OZONE_WL, 1
env = NIXPKGS_ALLOW_UNFREE, 1
env = XDG_CURRENT_DESKTOP, Hyprland
env = XDG_SESSION_TYPE, wayland
env = XDG_SESSION_DESKTOP, Hyprland
exec-once = export MOZ_ENABLE_WAYLAND=1
exec-once = export XDG_CURRENT_DESKTOP=Hyprland
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = sleep .5 && swww init
exec-once = sleep .5 && waybar
exec-once = sleep 3 && swww img /astolfos/content/astolfo.png
exec-once = steam
exec-once = librewolf
#my monitorconfig

monitor=DP-1,2560x1440@59.95,7040x0,1.0
monitor=DP-3,1920x1200@59.95,2576x240,1.0
monitor=HDMI-A-1,2560x1440@59.95,4480x0,1.0


$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, kitty
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, fuzzel 
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, D, exec, discordptb 
bind = $mainMod SHIFT, S, exec, sh /home/astolfo/screenshot

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
