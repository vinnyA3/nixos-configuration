{
  description = "System configuration flake";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25f538306313eae3927264466c70d7001dcea1df";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix?rev=4f63f01c1e7729085998dd39201dedad3e700cb5";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      sys = "x86_64-linux";
      unstable-overlays = {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          })
        ];
      };
    in
    {
      nixosConfigurations = {
        "nixos-beelink" = nixpkgs.lib.nixosSystem {
          system = sys;
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.qwerty = ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
              };
            }
            unstable-overlays
          ];

          specialArgs = { inherit inputs; };
        };
      };
    };
}
