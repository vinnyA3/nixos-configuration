{ pkgs, config }:

{
  imports = [
    ./hardware-configuration.nix
    ./common.nix
    ./services/xserver.nix
  ];

  networking.hostName = "zerodayz";
  networking.wireless.enable = true;

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/60de27b0-6761-499b-a7f4-9b5603db2d12";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Enable sound + pulseaudio
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  environment.systemPackages = with pkgs;
    let 
      main = [
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
        figlet
        aspell
        aspellDicts.en
        htop
        lynx
        man-pages
        playerctl
        gtypist
        weechat
        unzip
        stow
      ];
      
      # xorg pkgs installed when Xorg is availabe as display server
      xorg = [
        emacs
        firefox
        feh
        qutebrowser
        mpv
        python36Packages.mps-youtube
        haskellPackages.xmobar
        haskellPackages.brittany
        haskellPackages.pandoc
        st
        unclutter
        xclip
        zathura
        xorg.xmodmap
        rofi
        inkscape
        scrot
        gimp
        compton
      ];

      noxorg = [];
    in main ++ (if config.services.xserver.enable then xorg else noxorg);
}
