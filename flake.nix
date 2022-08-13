{
  description = "Winston's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    darwin.url  = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, home-manager, nixpkgs }: {
    darwinConfigurations = {
      "Winstons-MacBook" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./configuration.nix

          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.winston = import ./home.nix;
          }
        ];
      };
    };
  };
}