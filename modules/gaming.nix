{ pkgs, lib, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "nexusmods-app-unfree-0.21.1"
  ];

  programs.gamemode = {
    enable = lib.mkDefault false;
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "high";
      };
    };
  };

  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam.override {
      extraArgs = "-pipewire";
    };

    remotePlay.openFirewall = true;
    protontricks = {
      enable = true;
    };
  };
}
