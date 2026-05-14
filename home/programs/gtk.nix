{ ... }: {
  gtk = {
    enable = true;

    theme = {
      name = "ClassicPlatinumStreamlined";
      # Theme will be manually installed to ~/.local/share/themes
    };

    iconTheme = {
      name = "RetroismIcons";
      # Icon theme will be manually installed to ~/.local/share/icons
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = false;  # Retro theme is light-based
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = false;
    };
  };
}
