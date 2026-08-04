{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "nexusmods-app-unfree-0.21.1"
  ];

  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };
}
