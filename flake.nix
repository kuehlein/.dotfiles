{
  description = "NixOS config with multiple setups (Sway, Hyprland & DWM)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-config.url = "github:kuehlein/neovim-config";
  };

  outputs = { home-manager, neovim-config, nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.t490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit neovim-config; };
        modules = [
          ./configuration.nix
          ./modules/common.nix

          ./setups/common.nix
          ./setups/sway/default.nix
          # ./setups/hyprland/default.nix
          # ./setups/dwm/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true; # Share system pkgs.
              useUserPackages = true; # Install user pkgs to profile.
              users = {
                kuehlein = import ./home/kuehlein.nix;
                kyle = import ./home/kyle.nix;
              };
            };
          }
        ];
      };
    };
}
