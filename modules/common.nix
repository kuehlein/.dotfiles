{ config, lib, neovim-config, pkgs, ... }: {
  imports = [ ./witr.nix ];

  # Enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # Apps
      inkscape libreoffice proton-pass vlc

      # Bluetooth
      blueman

      # Browsing
      brave mullvad mullvad-browser mullvad-vpn tor tor-browser

      # Dev (general)
      claude-code neovim-config.packages.${system}.default sqlite

      # Git & SSH
      git openssh

      # Hardware Utilities
      inxi lshw dmidecode pulseaudio

      # Input Methods
      fcitx5-configtool

      # Misc.
      cacert fastfetch grim lm_sensors mako slurp wl-clipboard

      # Nix
      direnv nix-prefetch-scripts

      # Utilities
      bat curl fd htop jq ripgrep tmux tree unzip wget zip
    ];
    variables = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
      GIT_SSL_CAINFO = "/etc/ssl/certs/ca-bundle.crt";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";

      # fcitx5 environment variables for Wayland
      GLFW_IM_MODULE = "ibus";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "t490";
    networkmanager.enable = true;
  };

  powerManagement.enable = true;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-curses;
    };
    ssh.startAgent = true;
    zsh.enable = true;
  };

  security.polkit.enable = true;

  services = {
    blueman.enable = true;
    displayManager = {
      ly.enable = true;
      sessionPackages = with pkgs; [ sway ];
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
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  time.timeZone = "America/New_York";

  users.users = {
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
      isNormalUser = true;
      shell = pkgs.zsh;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
