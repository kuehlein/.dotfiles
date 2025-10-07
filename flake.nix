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

  outputs = { home-manager, nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      # TODO: do we want something like this?
      # i think this replaces the `home-manager.nixosModules.home-manager` bit below
	#      homeConfigurations."???" =
	#        inputs.home-manager.lib.homeManagerConfiguration {
	#   inherit pkgs;
	#
	#   modules = [ ./home/kuehlein.nix ];
	#
	#   extraSpecialArgs = { inherit inputs };
	# };

      nixosConfigurations.t490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
	      extraSpecialArgs = { inherit inputs; };
	      useGlobalPkgs = true; # Share system pkgs.
	      useUserPackages = true; # Install user pkgs to profile.
	      users.kuehlein = import ./home/kuehlein.nix;
	      users.kyle = import ./home/kyle.nix;
	    };
	  }
        ];
      };
    };
}
