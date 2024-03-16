# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./virtualboxfix.nix
    ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "T460"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

#  _                    _
# | |    ___   ___ __ _| | ___
# | |   / _ \ / __/ _` | |/ _ \
# | |__| (_) | (_| (_| | |  __/
# |_____\___/ \___\__,_|_|\___|
# locale

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

#  _____                   _             _
# |_   _|__ _ __ _ __ ___ (_)_ __   __ _| |
#   | |/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
#   | |  __/ |  | | | | | | | | | | (_| | |
#   |_|\___|_|  |_| |_| |_|_|_| |_|\__,_|_|
# terminal tty

	programs.zsh.enable = true;
	programs.neovim.defaultEditor = true;
	users.defaultUserShell = pkgs.zsh;
	environment.localBinInPath = true;
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

# named fonts.packages on newer than 23.05
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-emoji
		ultimate-oldschool-pc-font-pack
	];

# __  __  _   _
# \ \/ / / | / |
#  \  /  | | | |
#  /  \  | | | |
# /_/\_\ |_| |_|
# X11
	services.xserver = {
		enable = true;
		xkb.layout = "us";
		xkb.options = "eurosign:e,caps:escape";
		displayManager.lightdm.enable = true;
		desktopManager.xfce.enable = true;
		# windowManager.dwm.package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
		# 		src = builtins.fetchTarball {
		# 		url = "https://github.com/flexbusterman/dwm/archive/flexmaster.tar.gz";
		# 		# sha256 = "0azn8xqh9ig6bk639wywqdx8hay9ch6nk62scij7zs2xd22yv8c4";
		# 		};
		# 		});
		# windowManager.dwm.enable = true;

		windowManager.bspwm = {
			enable = true;
			configFile = ./dotfiles/bspwm/bspwmrc;
			sxhkd.configFile = ./dotfiles/sxhkd/sxhkdrc;
		};

	};

#  ____             _
# |  _ \  _____   _(_) ___ ___  ___
# | | | |/ _ \ \ / / |/ __/ _ \/ __|
# | |_| |  __/\ V /| | (_|  __/\__ \
# |____/ \___| \_/ |_|\___\___||___/
# devices

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

#  ____            _
# |  _ \ __ _  ___| | ____ _  __ _  ___  ___
# | |_) / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
# |  __/ (_| | (__|   < (_| | (_| |  __/\__ \
# |_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
# packages                   |___/

	# tarball-ttl = 1;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.flex = {
		isNormalUser = true;
		description = "flex";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			dropbox
			mpv
			qutebrowser
			reaper
			slack
			yt-dlp
		];

	};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

		bat
		blueberry
		bluez
		btop
		cargo
		coreutils
		du-dust
		dunst
		eza
		fzf
		gcc
		git
		gnumake
		kitty
		libnotify
		neofetch
    neovim
		nodejs
		p7zip
		pamixer
		pass
		pavucontrol
		pulsemixer
		python3
		python311Packages.xlib
    ranger
		ripgrep
		rustc
		tldr
    tmux
		tree
		unzip
		vim
		w3m
    wget
		xclip
		xorg.xkill
		zplug
		zsh

		(dmenu.overrideAttrs (oldAttrs: rec { src = builtins.fetchTarball { url = "https://github.com/flexbusterman/dmenu/archive/master.tar.gz";
		# sha256="15n6c1baba8mfncbzqzdbmv4116yblfm5kl7xl5mf6vpy40y433r";
		}; }))
		# (st.overrideAttrs (oldAttrs: rec { src = builtins.fetchTarball { url = "https://github.com/flexbusterman/st/archive/flexmaster.tar.gz";
		# # sha256="0cr9m8fay1dkfjxs9pbxwv5k3m5r3fiwbjp10kcd1rq2nbngcyby";
		# }; }))
		# (st.overrideAttrs (oldAttrs: rec { src = builtins.fetchTarball { url = "https://github.com/flexbusterman/dwmblocks/archive/flex.tar.gz";
		# # sha256="0cr9m8fay1dkfjxs9pbxwv5k3m5r3fiwbjp10kcd1rq2nbngcyby";
		# }; }))
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
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
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  #services.xserver.videoDrivers = lib.mkForce [ "vmware" "virtualbox" "modesetting" ];

  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };

}
