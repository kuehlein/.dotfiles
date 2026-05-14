{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=WebUIDarkMode,HeuristicMemorySaver"
      "--force-dark-mode"
    ];
    package = pkgs.brave;
  };

  # Tell applications that use the "system theme" to use a dark theme
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  # Ensure GTK apps report dark mode preference
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };
}
