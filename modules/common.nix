{ config, pkgs, ... }: {
  # Enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true; # TODO: consider not using systemd... (grub)?
  };

  environment.systemPackages = with pkgs; [
    # Apps
    inkscape libreoffice vlc

    # Browsing
    brave mullvad mullvad-browser mullvad-vpn tor tor-browser

    # Development
    git neovim

    # Misc.
    grim mako slurp wl-clipboard

    # Utilities
    bat curl fd htop ripgrep tmux tree unzip wget zip
  ];

  networking = {
    firewall.enable = true;
    hostName = "t490";
    networkmanager.enable = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
    zsh.enable = true;
  };

  security.polkit.enable = true;

  services = {
    displayManager = {
      ly.enable = true;
      sessionPackages = with pkgs; [ sway ]; # hyprland st
    };
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true; # Inverts scroll direction
    };
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  time.timeZone = "America/New_York";

  users.users = {
    # TODO: refine user configuration
    kyle = {
      description = "TODO...";
      extraGroups = [ "networkmanager" "wheel" ];
      isNormalUser = true;
    };

    kuehlein = {
      description = "kuehlein - admin";
      extraGroups = [
        "audio" # Access to audio devices (e.g., sound cards).
        "docker" # If using Docker, for container management.
        "input" # For input devices if needed.
        "libvirtd" # If using virtualization like QEMU/KVM.
        "networkmanager" # Allows managing networks without root.
        "video" # Access to video devices (e.g., webcams, GPUs).
        "wheel" # Enables sudo access.
      ];
      initialPassword = "changeme";
      isNormalUser = true;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
