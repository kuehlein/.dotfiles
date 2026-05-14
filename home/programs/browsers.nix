{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=WebUIDarkMode,HeuristicMemorySaver"
      "--force-dark-mode"
    ];
    package = pkgs.brave;
  };

  # Tell websites to prefer dark mode (independent of GTK theme)
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
}
