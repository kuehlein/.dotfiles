# TODO: The config for this user should be oriented towards regular browsing/use.

{ pkgs, ... }: {
  home.stateVersion = "25.05";

  imports = [ ./common.nix ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
