# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  virtualisation.docker.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  users = {
    groups = {
      docker = {};     
    };

    users = {
      # Define a user account. Don't forget to set a password with ‘passwd’.
      qwerty = {
        isNormalUser = true;
        home = "/home/qwerty";
        description = "domo same desu";
        extraGroups = [ "wheel" "networkmanager" "docker"];
      };
    };
  };

  environment.variables = { EDITOR = "vim"; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = [
    (pkgs.vim_configurable.customize {
        name = "vim";

        vimrcConfig.customRC = ''
          " custom / system-wide RC
          set nocompatible
          set hidden " avoid term buffers from closing on buffer switch
          
          nnoremap <Space> <Nop>
          vnoremap <Space> <Nop>
          let mapleader = " "

          syntax on
          set encoding=UTF-8
          set noshowmode
          set splitbelow
          set splitright
          set number
          set textwidth=80
          set nohls
          set noshowmatch
          set noshowmode
          setlocal spell spelllang=en_us
          set nospell
          set modeline
          set nojoinspaces
          
          set autoindent
          set indentexpr=off
          set expandtab
          set tabstop=2
          set softtabstop=2
          set shiftwidth=2

          set nowritebackup
          set noswapfile
          set nobackup
        
          set path+=**
          set wildmenu
          
          set completeopt=menuone,noinsert,noselect
          set shortmess+=c
        '';
    }
  )];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.ssh = {
    startAgent = true;
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
  system.stateVersion = "21.11"; # Did you read the comment?
}

