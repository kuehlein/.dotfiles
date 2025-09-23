{ config, pkgs, ... }: let
  wallpaper = ../../assets/sun.jpg;
in {
  imports = [ ./waybar ./wofi ];

  environment = {
    # TODO: configure without using `.text`?
    etc."sway/config".text = ''
      # This is the sway config file made by diinki, as part of a retro futuristic linux rice,
      # made for my "Linux Ricing Guide" video, watch it if you want to learn more about linux
      # and ricing!
      #
      # The license is included in the repo (MIT License)


      # ===================== BASIC START-UP STUFF ======================

      # Set the default font used by sway, I like maple mono.
      font pango:Maple Mono Regular 10

      # Start the auth agent, if you don't use this you can comment out this line.
      # exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      # exec --no-startup-id sh -c ' eval $(gnome-keyring-daemon --login) eval $(gnome-keyring-daemon --start --components=secrets,ssh) export SSH_AUTH_SOCK'
      # Start the network manager applet, can comment out this line if you don't use network manager.
      exec nm-applet

      # =================================================================


      # ===================== WALLPAPER =================================
      # You can have different wp per monitor by changing the *
      # to the specific display output.

      output * bg ${wallpaper} fill
      # =================================================================


      # ===================== APP VARIABLES =============================
      # These are the applications we use, and also where I set the 
      # mod key (in this case it's the super key, i.e the windows key.)
      set $mod Mod4
      set $left h
      set $down j
      set $up k
      set $right l
      set $term kitty
      set $application_launcher pgrep wofi >/dev/null 2>&1 && killall wofi || wofi --show drun

      # --- THE FILE EXPLORER! I recommend either nautilus or nemo, personally I think nautilus fits nicely,
      # --- although make sure to install and use my GTK theme, guide on that is in the github README.
      set $file_explorer GTK_THEME=diinki-retro-dark nautilus
      # =================================================================



      # ===================== BORDERS & GAPS ============================

      # Gaps between windows
      gaps inner 8px
      gaps outer 4px

      # Border width, I prefer THIN borders ^-^
      default_border pixel 1px
      default_floating_border pixel 1px


      # The border colors:

      #                         border    bg        text      ind       child border
      client.focused          #d8cab8 #141216 #d8cab8 #d8cab8 #d8cab8
      client.focused_inactive #AC82E9 #141216 #d8cab8 #AC82E9 #AC82E9
      client.unfocused        #AC82E9 #141216 #d8cab8 #AC82E9 #AC82E9
      client.urgent           #fcb167 #141216 #d8cab8 #fcb167 #fcb167
      client.placeholder      #AC82E9 #141216 #d8cab8 #AC82E9 #AC82E9

      # =================================================================



      # ===================== INPUT & KEYBOARD ==========================

      # I've included an example for dual keyboard layouts here, english and swedish,
      # as it's what I use. You can add/remove languages, change from "us,se" to "us,es"
      # for instance, if you want spanish; or any other.
      # You toggle between the languages with ALT+SHIFT
      input * {
        xkb_layout "us,se"
        xkb_options "grp:alt_shift_toggle"
      }

      # =================================================================



      # ===================== THE INFO/TASKBAR ==========================
      # Simple, this just starts waybar which is what we are using.
      bar {
        swaybar_command waybar
      }
      # =================================================================



      # ===================== SCREENSHOTS ===============================
      # There's a few different ways to handle screenshots in an
      # easy way, I've decided to use a combination of three apps:
      # grim, slurp, and swappy. Feel free to use a different screenshot
      # solution.


      #bindsym $mod+Shift+s exec "QT_QPA_PLATFORM=xcb flameshot gui"
      bindsym $mod+Shift+s exec grim -g "$(slurp)" - | swappy -f -

      # =================================================================



      # ===================== BASIC KEYBINDS ============================
      # These are the most basic keybinds which are very commonly used, 
      # feel free to change them, the usage/syntax should be easy to
      # understand and edit.


      bindsym $mod+Return exec $term
      bindsym $mod+e exec $file_explorer
      bindsym $mod+d exec $application_launcher
      bindsym $mod+q kill
      bindsym $mod+Shift+c reload
      bindsym $mod+Shift+space floating toggle

      floating_modifier $mod normal

      # Exit sway command, I add a pop-up so you can't do this on accident, thank me later.
      bindsym $mod+Shift+e exec swaynag -t warning -m "Are you sure you want to exit sway?" -B "Yes, EXIT!" "swaymsg exit" --font="CaskaydiaCove Nerd Font bold 12"
      # ================================================================



      # ===================== OTHER STANDARD BINDINGS ==================

      # These are the standard bindings, such as switching workspace, moving windows to different
      # workspaces, etc. Feel free to edit to your liking.

      bindsym $mod+f fullscreen
      bindsym $mod+$left focus left
      bindsym $mod+$down focus down
      bindsym $mod+$up focus up
      bindsym $mod+$right focus right
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right
      bindsym $mod+Shift+$left move left
      bindsym $mod+Shift+$down move down
      bindsym $mod+Shift+$up move up
      bindsym $mod+Shift+$right move right
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right

      # Switch the monitor to a specific workspace.
      bindsym $mod+1 workspace number 1
      bindsym $mod+2 workspace number 2
      bindsym $mod+3 workspace number 3
      bindsym $mod+4 workspace number 4
      bindsym $mod+5 workspace number 5
      bindsym $mod+6 workspace number 6
      bindsym $mod+7 workspace number 7
      bindsym $mod+8 workspace number 8
      bindsym $mod+9 workspace number 9
      bindsym $mod+0 workspace number 10

      # Move hovered windows to a specific workspace.
      bindsym $mod+Shift+1 move container to workspace number 1
      bindsym $mod+Shift+2 move container to workspace number 2
      bindsym $mod+Shift+3 move container to workspace number 3
      bindsym $mod+Shift+4 move container to workspace number 4
      bindsym $mod+Shift+5 move container to workspace number 5
      bindsym $mod+Shift+6 move container to workspace number 6
      bindsym $mod+Shift+7 move container to workspace number 7
      bindsym $mod+Shift+8 move container to workspace number 8
      bindsym $mod+Shift+9 move container to workspace number 9
      bindsym $mod+Shift+0 move container to workspace number 10
      bindsym $mod+a focus parent
      # ==============================================================

      exec_always dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      exec waybar



      # set $mod Mod4
      # floating_modifier $mod

      # # Scratchpad
      # bindsym $mod+Shift+space move scratchpad
      # bindsym $mod+space scratchpad show

      # # Workspaces
      # workspace 0
      # workspace 1
      # workspace 2

      # # Keybindings for workspaces
      # bindsym $mod+0 workspace 0
      # bindsym $mod+1 workspace 1
      # bindsym $mod+2 workspace 2
      # bindsym $mod+Shift+0 move container to workspace 0
      # bindsym $mod+Shift+1 move container to workspace 1
      # bindsym $mod+Shift+2 move container to workspace 2

      # # Minimal outputs/input
      # output * bg #000000 solid_color
      # input * {
      #   xkb_layout us
      #   xkb_options ctrl:nocaps
      # }

      # # Start a terminal
      # bindsym $mod+Return exec kitty

      # # ???
      # bindsym $mod+d exec wofi --show drun

      # # Ensures D-Bus sees keyring env
      # exec dbus-activation-environment --all
    '';
    sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # Development
      gcc kitty nodejs python3

      # Desktop
      swaylock waybar wayidle wofi
    ];
    wrapperFeatures.gtk = true;
  };

  security.pam.services.swaylock = {};
}
