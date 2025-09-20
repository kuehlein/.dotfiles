# TODO: The config for this user should be oriented towards regular browsing/use.

{ pkgs, ... }: {
  home.stateVersion = "25.05"; # TODO: not sure about this...

  programs.zsh = {
    enable = true;
    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK=$(gnome-keyright-daemon --start --components=ssh | grep SSH_AUTH_SOCK | cut -d= -f2)
      fi
    '';
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
