{ config, lib, pkgs, ... }: {
  # Enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true; # TODO: consider not using systemd... (grub)?
  };

  environment.systemPackages = with pkgs; [
    # Apps
    inkscape libreoffice proton-pass vlc

    # Browsing
    brave mullvad mullvad-browser mullvad-vpn tor tor-browser
    # brave-wrapped

    # Development
    git neovim

    # Misc.
    fastfetch grim lm_sensors mako slurp wl-clipboard

    # Nix
    nix-prefetch-scripts

    # Utilities
    bat curl fd htop ripgrep tmux tree unzip wget zip

    # Hardware Utilities
    inxi lshw dmidecode pulseaudio
  ];

  networking = {
    firewall.enable = true;
    hostName = "t490";
    networkmanager.enable = true;
  };

  powerManagement.enable = true;

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
      sessionPackages = with pkgs; [ sway ]; # hyprland dwm
    };
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true; # Inverts scroll direction
    };
    logind.settings.Login = {
      HandleLidSwitch = "suspend"; # Sleep on close laptop lid
      HandleLidSwitchDocked = "ignore";
      IdleAction = "suspend";
      IdleActionSec = 300; # 5 minutes before sleep
      LockScreen = true; # Display lock screen after sleep
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
      shell = pkgs.zsh;
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
      shell = pkgs.zsh;
    };
  };

  # TODO: not sure about this...
  xdg.portal.enable = lib.mkForce false;
}
