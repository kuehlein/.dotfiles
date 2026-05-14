{ ... }: {
  imports = [
    ./programs/browsers.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/gtk.nix
    ./programs/kitty.nix
    ./programs/quickshell
    # ./programs/waybar          # Disabled - replaced by Quickshell
    # ./programs/wofi            # Disabled - replaced by Quickshell launcher
    ./programs/zsh.nix
  ];

  home.stateVersion = "25.05";

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
