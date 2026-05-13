{ pkgs, ... }: {
  services = {
    displayManager = {
      ly.enable = true;
      sessionPackages = with pkgs; [ sway ];
    };

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true; # Inverts scroll direction
    };

    logind.settings.Login = {
      HandleLidSwitch = "suspend";      # Sleep on close laptop lid
      HandleLidSwitchDocked = "ignore";
      IdleAction = "suspend";
      IdleActionSec = 300;               # 5 minutes before sleep
      LockScreen = true;                 # Display lock screen after sleep
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  security.polkit.enable = true;
}
