{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.dragonPc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/global-config.nix
          ./hosts/dragonPc/configuration.nix
          ./modules/kde/kde.nix
          ./users/archie/default.nix
          ./modules/qemu/default.nix

          home-manager.nixosModules.default

          {
            home-manager.users.archie = {
              imports = [
                ./modules/users/archie/home.nix
              ];
            };
          }
        ];
      };
    };
}

