{ pkgs, ... }:
{
  imports = [
    ../../modules/common.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/networking.nix
    ../../modules/security.nix
    ../../modules/session-vars.nix

    (import ../../modules/greeter.nix {
      user = "qwerty_asdf";
    })
  ];

  networking.hostName = "galp";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services.printing.enable = false; # CUPS

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;

  services.getty.autologinUser = "qwerty_asdf";

  users.groups.nixconf = {
    members = [ "qwerty_asdf" ];
  };

  users.users.qwerty_asdf = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "sudo"
    ];

    shell = pkgs.zsh;
  };
}
