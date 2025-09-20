# TODO: is this a better way to do this?
# { config, lib, pkgs, ... }: let
#   swayConfig = {
#     modifier = "Mod4";
#     floating_modifier = "Mod4";
#     input = {
#       "*" = {
#         xkb_layout = "us";
# 	xkb_options = "ctrl:nocaps";
#       };
#     };
#     ouput = {
#       "*" = { bg = "#000000 solid_color"; };
#     };
#     keybindings = {
#       "${swayConfig.modifier}+Return" = "exec kitty";
#       "${swayConfig.modifier}+Shift+space" = "move scratchpad";
#       "${swayConfig.modifier}+space" = "scratchpad show";
#       "${swayConfig.modifier}+0" = "workspace 0";
#       "${swayConfig.modifier}+1" = "workspace 1";
#       "${swayConfig.modifier}+2" = "workspace 2";
#       "${swayConfig.modifier}+Shift+0" = "move container to workspace 0";
#       "${swayConfig.modifier}+Shift+1" = "move container to workspace 1";
#       "${swayConfig.modifier}+Shift+2" = "move container to workspace 2";
#     };
#   };
#
#   generateSwayConfig = cfg: lib.concatStringSep "\n" (lib.mapAttrsToList (section: values:
#     if lib.isAttrs values then
#       "${sectoin} {\n" + (lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "  ${k} ${v}")) + "\n}")
#     else
#       "${section} ${values}"
#   ) cfg);
# in {
#   programs.sway = {
#     enable = true;
#
#     # TODO: how to do this??.......
#     environment = {
#       sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
#       systemPackages = with pkgs; [
#         # Development
# 	gcc nodejs python3
#       ];
#     };
#     # .............................
#
#     extraPackages = with pkgs; [
#       kitty
#       swaylock
#       waybar
#       wayidle
#     ];
#
#     security.pam.services.swaylock = {};
#
#     wrapperFeatures.gtk = true;
#   };
# }

{ config, pkgs, ... }: {
  environment = {
    # TODO: configure without using `.text`?
    etc."sway/config".text = ''
      set $mod Mod4
      floating_modifier $mod

      # Scratchpad
      bindsym $mod+Shift+space move scratchpad
      bindsym $mod+space scratchpad show

      # Workspaces
      workspace 0
      workspace 1
      workspace 2

      # Keybindings for workspaces
      bindsym $mod+0 workspace 0
      bindsym $mod+1 workspace 1
      bindsym $mod+2 workspace 2
      bindsym $mod+Shift+0 move container to workspace 0
      bindsym $mod+Shift+1 move container to workspace 1
      bindsym $mod+Shift+2 move container to workspace 2

      # Minimal outputs/input
      output * bg #000000 solid_color
      input * {
        xkb_layout us
        xkb_options ctrl:nocaps
      }

      # Start a terminal
      bindsym $mod+Return exec kitty

      # Ensures D-Bus sees keyring env
      exec dbus-activation-environment --all
    '';
    sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # Development
      gcc kitty nodejs python3

      # Sway
      swaylock waybar wayidle
    ];
    wrapperFeatures.gtk = true;
  };

  security.pam.services.swaylock = {};
}
