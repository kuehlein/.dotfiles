{ pkgs, ... }: {
  services = {
    displayManager = {
      ly.enable = true;
      sessionPackages = with pkgs; [ sway ];
    };

    # Lid switch behavior
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
}
