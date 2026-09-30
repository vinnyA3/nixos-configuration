{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.ocean-sound-theme
  ];
}
