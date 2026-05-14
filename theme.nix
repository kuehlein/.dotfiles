# Design tokens for the NixOS desktop environment
# Based on linux-retroism by diinki
# Source: https://github.com/diinki/linux-retroism

{
  # Color Palette (Default Theme)
  colors = {
    # Base colors
    background = "101010";      # Dark background
    foreground = "d8d8d8";      # Light gray text
    surface = "141216";         # Surface color (window backgrounds)

    # Primary accent
    primary = "207874";         # Teal/cyan accent
    cursor = "207874";          # Cursor color

    # Selection
    selection = "d8d8d8";       # Selection background (light gray)
    selectionText = "207874";   # Selected text (teal)

    # Window borders (from sway config)
    borderFocused = "d8d8d8";           # Focused window border (light gray)
    borderFocusedInactive = "9b9b9b";   # Focused inactive (medium gray)
    borderUnfocused = "9b9b9b";         # Unfocused windows (medium gray)
    borderUrgent = "fca002";            # Urgent windows (orange)
    borderPlaceholder = "bababa";       # Placeholder (lighter gray)

    # Terminal colors (ANSI)
    black = "9400ff";           # color0 - Purple
    red = "ff0000";             # color1 - Bright red
    green = "00ff5d";           # color2 - Bright green
    yellow = "fce40f";          # color5 - Bright yellow
    blue = "7b91fc";            # color4 - Light blue
    magenta = "ff00ee";         # color7 - Bright magenta
    cyan = "92fcfa";            # color8 - Cyan
    white = "d3d3d3";           # color15 - Light gray

    # Additional accent colors
    purple = "AC82E9";          # color3/11 - Purple accent
    violet = "8F56E1";          # color6/14 - Violet

    # Shadow
    shadow = "000000";          # Shadow color
  };

  # Typography
  fonts = {
    # Main UI font (classic bitmap fonts for retro look)
    ui = {
      family = "Terminus";      # Or "Tamzen", "Pixel Operator", etc.
      size = 10;
    };

    # Monospace font
    mono = {
      family = "Maple Mono NF"; # Keep your current mono font
      size = 10;
    };

    # Terminal font
    terminal = {
      family = "Terminus";
      size = 12;
    };
  };

  # Spacing & Layout (from linux-retroism sway config)
  spacing = {
    # Gaps and padding
    gapInner = 8;               # Inner gaps between windows
    gapOuter = 4;               # Outer gaps from screen edge

    # Border widths
    borderWidth = 1;            # Window border width (thin borders)
    borderWidthFocused = 1;     # Focused window border

    # Shadows (for SwayFX)
    shadowOffset = 4;           # Shadow offset (x and y)
    shadowBlurRadius = 1;       # Shadow blur radius

    # Terminal padding
    terminalPaddingX = 7;       # Terminal horizontal padding
    terminalPaddingY = 10;      # Terminal vertical padding

    # Bar/panel dimensions
    barHeight = 24;             # Top/bottom bar height
    barPadding = 4;             # Padding inside bars

    # Rounding (0 for retro sharp corners)
    cornerRadius = 0;           # Sharp corners for 90s aesthetic
  };

  # Window decorations
  decorations = {
    titleBarHeight = 20;        # Height of window title bars
    buttonSize = 16;            # Size of window control buttons
    borderStyle = "solid";      # Border style
  };

  # Icons & Cursors
  theme = {
    iconTheme = "Chicago95";    # Classic 90s icon theme (or similar)
    cursorTheme = "Retrosmart-xcursor"; # Retro cursor theme
    cursorSize = 24;
  };
}
