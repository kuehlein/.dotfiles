{ pkgs, ... }: let
  wallpaper = ../../assets/sun.jpg;
  swayConfig = ./sway-config;
in {
  environment = {
    etc."sway/config".text = builtins.concatStringsSep "\n" [
      (builtins.readFile swayConfig)
      "output * bg ${toString wallpaper} fill"
    ];
    sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  };

  fonts.packages = with pkgs; [
    maple-mono.NF
  ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # Terminal
      kitty

      # Desktop
      swaylock waybar wayidle wofi
    ];
    wrapperFeatures.gtk = true;
  };

  security.pam.services.swaylock = {};
}
