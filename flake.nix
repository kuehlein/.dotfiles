{
  description = "NixOS configuration with Sway for t490";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-config.url = "github:kuehlein/neovim-config";
  };

  outputs = { self, home-manager, neovim-config, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.t490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit neovim-config; };
        modules = [
          # Base configuration
          ./configuration.nix

          # System modules
          ./modules/system/boot.nix
          ./modules/system/networking.nix
          ./modules/system/packages.nix
          ./modules/system/users.nix

          # Services
          ./modules/services/audio.nix
          ./modules/services/display.nix

          # Programs
          ./modules/programs/sway.nix

          # Packages
          ./modules/packages/brave.nix
          ./modules/packages/witr.nix

          # Home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;    # Share system pkgs.
              useUserPackages = true;  # Install user pkgs to profile.
              users = {
                kuehlein = import ./home/kuehlein.nix;
              };
            };
          }

          # Allow unfree packages
          {
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
              "claude-code"
            ];
          }
        ];
      };
    };
}
