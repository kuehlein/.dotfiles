{ ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;

    history = {
      extended = true;
      save = 1000000000;
      size = 1000000000;
    };

    shellAliases = {
      # Bluetooth
      headphones = "bluetoothctl connect 38:18:4C:19:92:DE";
      headphones-off = "bluetoothctl disconnect 38:18:4C:19:92:DE";

      # Git
      g = "git";
      ga = "git add";
      gaa = "git add .";
      gc = "git commit";
      gst = "git status";

      # Misc
      nd = "nix develop --command zsh";
      s = "kitten ssh";
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
}
