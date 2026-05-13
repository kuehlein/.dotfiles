{ ... }: {
  imports = [
    ./programs/browsers.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/waybar
    ./programs/wofi
    ./programs/zsh.nix
  ];

  home.stateVersion = "25.05";

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
