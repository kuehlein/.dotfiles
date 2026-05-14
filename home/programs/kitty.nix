{ ... }:
let
  theme = import ../../theme.nix;
in {
  programs.kitty = {
    enable = true;

    settings = {
      # Cursor
      cursor_shape = "block";
      shell_integration = "no-cursor";

      # Padding
      window_padding_width = theme.spacing.terminalPaddingX;
      window_padding_height = theme.spacing.terminalPaddingY;

      # Scrollback
      scrollback_lines = 3000;

      # Font
      font_size = 11;

      # Opacity
      background_opacity = "0.985";

      # Colors (linux-retroism default theme)
      cursor = "#${theme.colors.cursor}";
      selection_background = "#${theme.colors.selection}";
      selection_foreground = "#${theme.colors.selectionText}";
      background = "#${theme.colors.background}";
      foreground = "#${theme.colors.foreground}";

      # ANSI colors
      color0 = "#${theme.colors.black}";
      color1 = "#${theme.colors.red}";
      color2 = "#${theme.colors.green}";
      color3 = "#${theme.colors.purple}";
      color4 = "#${theme.colors.blue}";
      color5 = "#${theme.colors.yellow}";
      color6 = "#${theme.colors.violet}";
      color7 = "#${theme.colors.magenta}";
      color8 = "#${theme.colors.cyan}";
      color9 = "#${theme.colors.red}";
      color10 = "#${theme.colors.green}";
      color11 = "#${theme.colors.purple}";
      color12 = "#${theme.colors.blue}";
      color13 = "#${theme.colors.yellow}";
      color14 = "#${theme.colors.violet}";
      color15 = "#${theme.colors.white}";
    };

    keybindings = {
      "ctrl+shift+plus" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
    };
  };
}
