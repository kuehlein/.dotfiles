{ config, pkgs, ... }: let
  waybarSettings = {
    enable = true;
    settings = {
      mainbar = {
        height = 0; # 26;
        layer = "bottom"; # "bot"; # "top";
	margin-bottom = 0;
	margin-left = 500;
	margin-right = 500;
	margin-top = 15;
        # output = [ "eDP-1" ];
        position = "top";
	spacing = 0;

        modules-left = [
	  # "hyprland/mode" # ???
	  "sway/workspaces"
	];
	modules-center = [
	  "custom/applauncher"
	];
        modules-right = [
	  "network"
	  "battery"
	  "pulseaudio"
	  "tray"
	  "clock"

	  # "sway/language" # ???
	];

	# "hyprland/workspaces" = {
	#   disable-scroll = true;
	#   all-outputs = false;
	#   tooltip = false;
	# };

        "sway/workspaces" = {
          all-outputs = true;
          disable-scroll = true;
	  tooltip = false;
          # persistent_workspaces = {
          #   "1" = [];
          #   "2" = [];
          #   "3" = [];
          #   "4" = [];
          # };
          # disable-click = true;
        };

        # TODO: i dont think i want this...
        "custom/applauncher" = {
          format = "〇";
          on-click = "pgrep wofi >/dev/null 2>&1 && killall wofi || wofi --show drun --location=top -y 15";
          tooltip = false;
        };
        tray = {
          spacing = 10;
          tooltip = false;
        };
        clock = {
          format = "󰅐 {:%H:%M}";
          tooltip = false;
        };
        network = {
          format-wifi = " {bandwidthDownBits}";
          format-ethernet = " {bandwidthDownBits}";
          format-disconnected = "󰤮 No Network";
          interval = 5;
          tooltip = false;
        };
        pulseaudio = {
          scroll-step = 5;
          max-volume = 150;
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-icons = [ "" "" " " ];
          nospacing = 1;
          format-muted = " ";
          on-click = "pavucontrol";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄{capacity}%";
          format-alt = "{icon} {time}";
          format-full = "󱈑 {capacity}%";
          format-icons = [ "󱊡" "󱊢" "󱊣" ];
        };
      };
    };
  };
  waybarConfig = builtins.toJSON waybarSettings;
in {
  environment = {
    etc."xdg/waybar/style.css".source = ./style.css;
    # systemPackages = with pkgs; [ waybar ];
  };

  # programs.waybar = {
  environment."xdg/waybar/config".text = waybarConfig;
}
