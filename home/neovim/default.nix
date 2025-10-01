{ config, pkgs, ... }: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;  # Sets $EDITOR to nvim
      # viAlias = true;        # Alias vi -> nvim
      # vimAlias = true;       # Alias vim -> nvim
      # extraPackages = with pkgs; [
      #   # LSP and completion tools (add more as needed)
      #   nil;                 # Nix LSP
      #   nodePackages.typescript-language-server;
      #   nodePackages.pyright; # Python LSP
      #   # Treesitter parsers (via extraLuaPackages below)
      # ];
      #
      # # Basic plugins via Nix (for ricing, you'll expand this)
      # plugins = with pkgs.vimPlugins; [
      #   # Syntax and colorscheme
      #   vim-nix;             # Nix syntax
      #   tokyonight-nvim;     # A popular dark theme (swap for your fave)
      #   # File explorer
      #   nvim-tree-lua;
      #   # Fuzzy finder
      #   telescope-nvim;
      #   plenary-nvim;        # Telescope dependency
      # ];

      # extraLuaConfig = builtins.readFile ./init.lua;
    };
  };

  # Optional: Symlink a shared config dir for modularity (e.g., for larger ricing)
  home.file.".config/nvim/after".source = ./after;
  home.file.".config/nvim/lua".source = ./lua;
  home.file.".config/nvim/plugin".source = ./plugin;
  home.file.".config/nvim/init.lua".source = ./init.lua;
}
