{ pkgs, ... }:

{
  networking.hostName = "zerodayz";

  imports = [
    ./common.nix
    ./hardware-configuration.nix
    ./services/xserver.nix
  ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Grub menu is painted slowly, lower resolution ...
  boot.loader.grub.gfxmodeEfi = "1024x768";

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/60de27b0-6761-499b-a7f4-9b5603db2d12";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  boot.cleanTmpDir = true;

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
  # services.printing.enable = true;

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.trustedInterfaces = [ "lo" ];

  # Host specific packages
  environment.systemPackages = with pkgs; [
    compton
    easytag     
    rofi
    inkscape
    scrot
    gimp
    papirus-icon-theme
    xorg.xmodmap
  ];
}
