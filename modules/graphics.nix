{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # steam/proton needs this
    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
}
