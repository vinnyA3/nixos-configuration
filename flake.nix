{
  description = "System configuration flake";

  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=95ca1e203c0750115fd4a6f17d5a245dfe6b1edd";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
            ./hosts/nixos-beelink/configuration.nix
            ./hosts/nixos-beelink/hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.qwerty = ./hosts/nixos-beelink/home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit inputs;
                  homeUser = "qwerty";
                };
              };
            }

            unstable-overlays
          ];

          specialArgs = { inherit inputs; };
        };

        "galp" = nixpkgs.lib.nixosSystem {
          system = sys;
          modules = [
            ./hosts/galp/configuration.nix
            ./hosts/galp/hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.qwerty_asdf = ./hosts/galp/home.nix;
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
