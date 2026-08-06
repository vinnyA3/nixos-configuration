{ pkgs, ... }:
{
  imports = [
    ../../modules/common.nix
    ../../modules/networking.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/session-vars.nix
    ../../modules/security.nix
    ../../modules/audio.nix
    ../../modules/gaming.nix
    ../../modules/graphics.nix

    (import ../../modules/greeter.nix {
      user = "qwerty";
    })
  ];

  networking.hostName = "xion";
  # turn off wireless & disable wpa-supplicant
  networking.networkmanager.unmanaged = [ "*-wlp192s0" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  services.getty.autologinUser = "qwerty";

  users.groups.nixconf = {
    members = [ "qwerty" ];
  };

  users.users.qwerty = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "sudo"
    ];

    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";
}
