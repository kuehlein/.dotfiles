{ config, pkgs, ... }: {
  environment = {
    etc."xdg/wofi/style.css".source = ./style.css;
    systemPackages = with pkgs; [ wofi ];
  };

  # home.packages = let {
  #   inherit (config.programs.password-store) package enable;
  # } in {
  #   lib.optional enable (pkgs.pass-wofi.override { pass = package; });
  # };

  programs.wofi = {
    enable = true; # this is redundant...?

	#    package = pkgs.wofi.overridesAttrs (oa: {
	#      patches =
	#        (oa.patches or [])
	# ++ [
	#   ./wofi-run-shell.patch
	# ];
	#    });

    settings = {
      allow_images = true;
      allow_markup = true;
      gtk_dark = false;
      hide_scroll = true;
      insensitive = false; # true?
      line_wrap = "word";
      lines = 8;
      location = "center";
      no_actions = true;
      prompt = "Search???";
      show_all = true;
      # term = "kitty";
      width = 500;
      # columns = 3;
      # image_size = 48;
      # matching = "multi-contains";
      # run-always_parse_args = true;
      # run-cache_file = "/dev/null";
      # run-exec_search = true;
    };
  };
}
