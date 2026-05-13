{ pkgs, ... }: {
  home.stateVersion = "25.05";

  imports = [ ./common.nix ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
