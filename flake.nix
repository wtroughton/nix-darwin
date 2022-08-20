{
  description = "Winston's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    darwin.url  = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, home-manager, ... }@inputs: 
  {
    darwinConfigurations = {
      "Starlight" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./darwin.nix
          ./modules/pam.nix
        ];
      };
    };
  };
}
