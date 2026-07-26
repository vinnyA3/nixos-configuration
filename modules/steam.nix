{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # steam/proton needs this
  };
}
