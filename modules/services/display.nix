{ pkgs, ... }: {
  services = {
    displayManager = {
      ly.enable = true;
      sessionPackages = with pkgs; [ sway ];
    };

    # Lid switch behavior
    logind.extraConfig = ''
      HandleLidSwitch=suspend
      HandleLidSwitchDocked=ignore
    '';
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.polkit.enable = true;
}
