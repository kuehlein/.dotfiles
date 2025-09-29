# { config, pkgs, ... }: let
#   wallpaper = ../../assets/sunset.jpg;
# in {
#   imports = [
#     ./waybar
#     # ./wofi
#   ];
#
#   environment = {
#     etc."sway/config".text = builtins.concatStringsSep "\n" [
#       (builtins.readFile ./config)
#       # (builtins.readFile ./config.keybinds)
#       "output * bg ${toString wallpaper} fill"
#     ];
#     sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
#   };
#
#   fonts.packages = with pkgs; [
#     maple-mono.NF
#   ];
#
#   programs.sway = {
#     enable = true;
#     extraPackages = with pkgs; [
#       # Development
#       gcc kitty nodejs python3
#
#       # Desktop
#       swaylock waybar wayidle wofi
#     ];
#     wrapperFeatures.gtk = true;
#   };
#
#   security.pam.services.swaylock = {};
# }
