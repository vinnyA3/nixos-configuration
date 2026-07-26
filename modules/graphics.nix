{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # steam/proton needs this
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
