# System Config
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/networking.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/session-vars.nix
    ../../modules/audio.nix

    (import ../../modules/greeter.nix {
      user = "qwerty";
    })
  ];

  networking.hostName = "nixos-beelink";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  services.getty.autologinUser = "qwerty";

  users.groups.nixconf = {
    members = [ "qwerty" ];
  };

  programs.hyprland = {
    enable = false;
    # withUWSM = true;
    # xwayland.enable = true;
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
