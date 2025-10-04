# TODO: This config should be oriented more towards super-user stuff

{ pkgs, ... }: {
  home.stateVersion = "25.05";

  imports = [
    ./common.nix
    # ./neovim
  ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" "ssh" ];
  };
}
