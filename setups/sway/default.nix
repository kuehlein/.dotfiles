{ config, pkgs, ... }: let
  wallpaper = ../../assets/sun.jpg;
in {
  imports = [
    ./waybar
    # ./wofi
  ];

  environment = {
    etc."sway/config".text = builtins.concatStringsSep "\n" [
      (builtins.readFile ./config)
      "output * bg ${toString wallpaper} fill"
    ];
    sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # Development
      gcc kitty nodejs python3

      # Desktop
      swaylock waybar wayidle wofi
    ];
    wrapperFeatures.gtk = true;
  };

  security.pam.services.swaylock = {};
}
