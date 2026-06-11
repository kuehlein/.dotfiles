{ ... }: {
  xdg.configFile."presenterm/config.yaml".text = ''
    defaults:
      max_columns: 9999
  '';
}
