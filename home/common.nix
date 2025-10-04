{ inputs, pkgs, ... }: {
  imports = [
    inputs.neovim-config.homeManagerModules.default
  ];

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

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=WebUIDarkMode,HeuristicMemorySaver" ];
      package = pkgs.brave;
    };
    zsh = {
      enable = true;
      # TODO: move this to separate file?
      initContent = ''
        if [[ -z "$SSH_AUTH_SOCK" ]]; then
          export SSH_AUTH_SOCK=$(gnome-keyright-daemon --start --components=ssh | grep SSH_AUTH_SOCK | cut -d= -f2)
        fi

        if [[ -n $PS1 && -z $TMUX ]]; then
          fastfetch
        fi
      '';
    };
  };
}
