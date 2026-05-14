{ pkgs, ... }: {
  # Quickshell config files
  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };
}
