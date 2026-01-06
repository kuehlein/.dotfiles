{ config, pkgs, ... }:
{
  wayland.windowManager.sway.config.input."type:touchpad" = {
    # Disable 
    middle_emulation = "disabled";
    click_method = "clickfinger";  # or "button_areas"
    tap = "enabled";
  };
}
