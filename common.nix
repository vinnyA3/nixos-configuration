# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, lib, pkgs, ... }:

with lib;

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.checkJournalingFS = false;
  # Grub menu is painted slowly, lower resolution ...
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.cleanTmpDir = true;

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
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  #############################################################################
  ## Services
  #############################################################################

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    allowPing = true; # Ping is enabled
    allowedTCPPorts = [ 80 8080 443 ];
    # trustedInterfaces = [ "lo" ];

    # Ports for syncthing
    # allowedTCPPorts = [ 22000 ];
    # allowedUDPPorts = [ 21027 ];
  };

  # Only keep the last 500MiB of systemd journal.
  services.journald.extraConfig = "SystemMaxUse=500M";

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

  programs.ssh = {
    startAgent = true; # ssh-agent requires SUID wrapper ; however, agent is a user service
  };

  #############################################################################
  ## User accounts
  #############################################################################

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

  #############################################################################
  ## Package management
  #############################################################################

  environment.variables = { EDITOR = "vim"; };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
