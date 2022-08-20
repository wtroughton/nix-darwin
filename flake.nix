{
  description = "Winston's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.05-darwin";
    darwin.url  = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs.url = "github:cmacrae/emacs";
    emacs.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, home-manager, ... }@inputs: 
    let 
      overlays = with inputs; [
        emacs.overlay
        neovim-nightly-overlay.overlay
      ];
    in
    {
      darwinConfigurations = {
        "Starlight" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          modules = [
            ./modules/darwin.nix
            ./modules/pam.nix

            home-manager.darwinModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.winston = {
                  imports = [ ./modules/home.nix ];
                };
              };
            }

            {
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
}
