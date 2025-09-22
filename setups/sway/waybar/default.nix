{ config, pkgs, ... }: {
  environment.etc."xdg/waybar/style.css".source = ./style.css;

  programs.waybar = {
    enable = true; # this is redundant...?
  };
}
