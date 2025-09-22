{ config, lib, pkgs, ... }: {
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

  # TODO: not sure about this...
  xdg.portal.enable = false;
  # xdg.portal = {
  #   enable = true;
  #   # config.common.default = [ "wlr" ];
  #   config.sway.default = lib.mkForce [ "wlr" ];
  #   extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
  #   wlr.enable = true;
  # };
}
