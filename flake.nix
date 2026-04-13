{
  description = "System configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=e0d2e91b931d6cc098b2447b49f778324abee5a8";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      sys = "x86_64-linux";
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
          ];

          specialArgs = { inherit inputs; };
        };
      };
    };
}
