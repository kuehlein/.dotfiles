{ pkgs, ... }: {
  # Tell applications that use the "system theme" to use a dark theme
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  home.file.".config/BraveSoftware/Brave-Browser/Default/Preferences".text = builtins.toJSON {
    brave = {
      theme_type = 2; # Dark theme
    };
    sync = {
      bookmarks_synced = true;
      everything_synced = false;
      history_synced = false;
      setting_synced = true;
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "gafhhkghbfjjkeiendhlofajokpaflmk"; } # Lace Wallet
      { id = "ondecobpcidaehknoegeapmclapnkgcl"; } # JSON Viewer
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
    ];
    extra-opts = {
      "--enable-features=WebUIDarkMode" = true;
    };
    package = pkgs.brave;
  };
}
