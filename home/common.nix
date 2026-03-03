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

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=WebUIDarkMode,HeuristicMemorySaver" ];
      package = pkgs.brave;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      history = {
        extended = true;
        save = 1000000000;
        size = 1000000000;
      };
      shellAliases = {
        s = "kitten ssh";
        g = "git";
        ga = "git add";
        gaa = "git add .";
        gc = "git commit";
        gst = "git status";
        vim = "nvim";
      };

      initContent = ''
        [ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
        ssh-add ~/.ssh/id_ed25519_github 2>&1 | grep -v "Identity added" || true

        if [[ -n $PS1 && -z $TMUX ]]; then
          fastfetch -c examples/21
        fi
      '';
    };
  };
}
