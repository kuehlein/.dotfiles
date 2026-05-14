{
  description = "NixOS configuration with Sway for t490";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-config.url = "github:kuehlein/neovim-config";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, neovim-config, nixpkgs, sops-nix, ... }:
    {
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
          ./modules/system/secrets.nix
          ./modules/system/security.nix
          ./modules/system/users.nix

          # Services
          ./modules/services/audio.nix
          ./modules/services/display.nix

          # Programs
          ./modules/programs/sway.nix

          # Packages
          ./modules/packages/brave.nix
          ./modules/packages/witr.nix

          # Secrets management
          sops-nix.nixosModules.sops

          # Home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
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
