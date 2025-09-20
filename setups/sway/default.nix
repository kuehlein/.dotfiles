{ config, pkgs, ... }: {
  programs.sway = {
    enable = true;

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
	  xkb_options ctrl:nocaps # Remaps Caps to Ctrl
        }

        # Start a terminal
        bindsym $mod+Return exec kitty

        # Ensures D-Bus sees keyring env
	exec dbus-activation-environment --all
      '';
      sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
      systemPackages = with pkgs; [
        # Development
	gcc nodejs python3
      ];
    };

    extraPackages = with pkgs; [
      kitty
      swaylock
      waybar
      wayidle
    ];

    security.pam.services.swaylock = {};

    wrapperFeatures.gtk = true;
  }
}
