# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [
      # absolute path - assumes default nixos config dir (when symlinked via
      # scaffold script (ln-hosts)
      /etc/nixos/hardware-configuration.nix
      ../../common.nix # common config (relative to nixos-configuration/hosts/<host>
    ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "nixlab";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;
}
