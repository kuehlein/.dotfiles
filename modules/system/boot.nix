{ ... }: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
