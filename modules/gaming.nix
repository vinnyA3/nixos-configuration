{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "nexusmods-app-unfree-0.21.1"
  ];

  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "high";
      };
    };
  };
}
