{ config, pkgs, ... }: {
  environment = {
    etc."xdg/waybar/style.css".source = ./style.css;
    etc."xdg/waybar/config".text = builtins.toJSON {
      height = 26;
      layer = "top";
      margin-bottom = 0;
      margin-left = 15; # 500;
      margin-right = 15; # 500;
      margin-top = 15;
      position = "top";
      spacing = 0;

      modules-left = [ "sway/workspaces" ];
      modules-center = [ "custom/applauncher" ];
      modules-right = [
        "network"
        "battery"
        "pulseaudio"
        "tray"
        "clock"
      ];

      "sway/workspaces" = {
        all-outputs = true;
        disable-scroll = true;
        tooltip = false;
      };

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
        format-wifi = "  {bandwidthDownBits}";
        format-ethernet = "  {bandwidthDownBits}";
        format-disconnected = "󰤮  No Network";
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
        format-alt = "{icon} {time}";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰂄 {capacity}%";
        format-full = "󱈑 {capacity}%";
        format-icons = [ "󱊡" "󱊢" "󱊣" ];
      };
    };

    systemPackages = with pkgs; [ waybar ];
  };
}
