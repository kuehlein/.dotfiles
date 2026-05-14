{ neovim-config, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      # Apps
      inkscape libreoffice proton-pass vlc

      # Browsing
      brave mullvad mullvad-browser mullvad-vpn tor tor-browser

      # Dev (general)
      claude-code gcc nodejs python3 neovim-config.packages.${system}.default sqlite

      # Git & SSH
      git openssh

      # Hardware Utilities
      inxi lshw dmidecode pulseaudio

      # Input Methods
      fcitx5-configtool

      # Misc.
      cacert fastfetch grim lm_sensors mako nemo quickshell slurp socat swappy wl-clipboard

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

  # Input method configuration
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };

  # System programs
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-curses;
    };
    ssh.startAgent = true;
  };

  powerManagement.enable = true;
}
