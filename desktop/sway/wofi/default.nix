{ config, pkgs, ... }: {
  environment = {
    etc."xdg/wofi/config".text = ''
      allow_images=true;
      allow_markup=true;
      gtk_dark=false;
      hide_scroll=true;
      insensitive=false;
      line_wrap="word";
      lines=8;
      location="center";
      no_actions=true;
      prompt="Search???";
      show_all=true;
      width=500;
    '';
    etc."xdg/wofi/style.css".source = ./style.css;
  };
}
