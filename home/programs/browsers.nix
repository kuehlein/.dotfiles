{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--enable-features=WebUIDarkMode,HeuristicMemorySaver" ];
    package = pkgs.brave;
  };

  # Tell applications that use the "system theme" to use a dark theme
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
}
