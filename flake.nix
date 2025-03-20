{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."dragonPc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/dragonPc/configuration.nix
        ./modules/kde/kde.nix
        ./modules/global-users.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    homeConfigurations."archie" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux; 
      modules = [ ./home.nix ];
    };
  };
}
