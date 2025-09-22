{ config, pkgs, ... }: {
  environment = {
    etc."xdg/waybar/style.css".source = ./style.css;
    systemPackages = with pkgs; [ waybar ];
  };

  programs.waybar = {
    enable = true; # this is redundant...?
  };
}
