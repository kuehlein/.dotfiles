{
  description = "NixOS config with multiple setups (Sway, Hyprland & DWM)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, self, ... }: {
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
