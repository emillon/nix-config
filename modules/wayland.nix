{ pkgs }: {
  home.packages = with pkgs; [ foot ];
  wayland.windowManager.sway = {
    enable = true;
    config.modifier = "Mod4";
    config.focus.wrapping = "yes";
    config.keybindings = let mod = "Mod4"; # XXX
    in pkgs.lib.mkOptionDefault {
      "${mod}+Shift+Return" = "exec ${pkgs.foot}/bin/foot";
      "${mod}+Shift+c" = "kill";
      "${mod}+q" = "reload";
      "${mod}+Tab" = "focus next";
      "${mod}+Return" = "move right";
      "${mod}+1" = "workspace number 1";
      "${mod}+2" = "workspace number 2";
      "${mod}+3" = "workspace number 3";
      "${mod}+4" = "workspace number 4";
      "${mod}+5" = "workspace number 5";
      "${mod}+6" = "workspace number 6";
      "${mod}+7" = "workspace number 7";
      "${mod}+8" = "workspace number 8";
      "${mod}+9" = "workspace number 9";
      "${mod}+0" = "workspace number 10";
      "${mod}+Shift+1" = "move container to workspace number 1";
      "${mod}+Shift+2" = "move container to workspace number 2";
      "${mod}+Shift+3" = "move container to workspace number 3";
      "${mod}+Shift+4" = "move container to workspace number 4";
      "${mod}+Shift+5" = "move container to workspace number 5";
      "${mod}+Shift+6" = "move container to workspace number 6";
      "${mod}+Shift+7" = "move container to workspace number 7";
      "${mod}+Shift+8" = "move container to workspace number 8";
      "${mod}+Shift+9" = "move container to workspace number 9";
      "${mod}+Shift+0" = "move container to workspace number 10";
      "${mod}+Left" = "workspace prev";
      "${mod}+Right" = "workspace next";
      "${mod}+Shift+Left" = "move container to workspace prev";
      "${mod}+Shift+Right" = "move container to workspace next";
      "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
      "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
      "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "${mod}+l" = "exec swaylock";
      "${mod}+space" = "layout toggle splith stacking";
      "${mod}+a" = "focus parent";
      "${mod}+Shift+q" =
        "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
    };
    # set $menu wofi --show run | xargs swaymsg exec --
    # default_border pixel 2
    # include /etc/sway/config-vars.d/*
    # output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill
    #     bindsym $mod+p exec $menu
    #     floating_modifier $mod normal
    # bar {
    #     swaybar_command waybar
    # }
    # include /etc/sway/config.d/*
  };
  services.kanshi.enable = true;
}
