{ config, lib, pkgs, ... }:

with lib;

{
  #############################################################################
  ## General
  #############################################################################

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "18.03"; # Did you read the comment?

  # Only keep the last 500MiB of systemd journal.
  services.journald.extraConfig = "SystemMaxUse=500M";

  # Collect nix store garbage and optimise daily.
  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  # Enable passwd and co.
  users.mutableUsers = true;


  #############################################################################
  ## Locale
  #############################################################################

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  #############################################################################
  ## Services
  #############################################################################

  networking.firewall = {
    # Ping is enabled
    allowPing = true;

    # Ports for syncthing
    # allowedTCPPorts = [ 22000 ];
    # allowedUDPPorts = [ 21027 ];
  };

  # Every machine gets an sshd
  services.openssh = {
    enable = true;

    # Only pubkey auth - disable
    passwordAuthentication = true; # for now ...
    # challengeResponseAuthentication = false;
  };

  # Syncthing for shared folders
  # services.syncthing = {
  #   enable = true;
  #   user   = "qwerty";
  # };

  #############################################################################
  ## User accounts
  #############################################################################

  users.users.qwerty = {
    isNormalUser = true;
    uid = 1000;
    description = "Vincent Aceto <vincent.aceto@gmail.com>";
    extraGroups = [ "wheel" "networkmanager" "tty" ];
  };


  #############################################################################
  ## Package management
  #############################################################################

  nixpkgs = {
     config.allowUnfree = true;
     config.packageOverrides = pkgs: {
       st = pkgs.callPackage ./ext-pkgs/st {
         conf = builtins.readFile ./ext-pkgs/st/st-config.h;
         patches =
           [ 
       ./ext-pkgs/st/st-vertcenter-20180320-6ac8c8a.diff
       ./ext-pkgs/st/st-alpha.diff
       ./ext-pkgs/st/st-xresources.diff ];
       };
 
       cmus = pkgs.callPackage ./ext-pkgs/cmus {};
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs;
    let
      # Packages to always install.
      common = [
      	wget
	neovim
	neomutt
	python36Packages.neovim
	tmux
	cmus
	git
	nmap
	file
	fortune
	aspell
	aspellDicts.en
	haskellPackages.brittany
	haskellPackages.pandoc
	elvish
	htop
	lynx
	man-pages
	playerctl
	gtypist
	weechat
	unzip
	stow
	rtv
      ];

      noxorg = [];

      # if xorg enabled, install these pkgs 
      xorg = [
        firefox
	feh
	qutebrowser
        mpv
	python36Packages.mps-youtube
	haskellPackages.xmobar
	st
	unclutter
        xclip
	# xorg.xmodmap
	zathura
      ];
    in common ++ (if config.services.xserver.enable then xorg else noxorg);
}

