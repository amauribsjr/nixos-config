{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    
    settings = {
      # --- Monitor ---
      monitor = [
        "DP-2,2560x1440@180,0x0,1"
        "HDMI-A-1,1920x1080@60,2560x180,1"
      ];

      # --- Workspace Assignment ---
      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "10, monitor:HDMI-A-1"
      ];

      # --- Autostart ---
      exec-once = [
        "xrandr --output DP-2 --primary"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "swww-daemon"
        "sleep 1 && swww img ~/Pictures/wallpaper.png --resize crop"
        "waybar"
        "nm-applet --indicator"
      ];

      # --- Environment Variables ---
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];

      # --- Input ---
      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0;
      };

      # --- General ---
      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(8ec07c)";
        "col.inactive_border" = "rgb(504945)";
        layout = "dwindle";
      };

      # --- Decoration ---
      decoration = {
        rounding = 3;
        blur = {
          enabled = false;
        };
      };

      # --- Animations ---
      animations = {
        enabled = false;
      };

      # --- Layouts ---
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # --- Variables ---
      "$mainMod" = "SUPER";
      "$term" = "alacritty";
      "$menu" = "rofi -show drun -show-icons";

      # --- Keybinds ---
      bind = [
        "$mainMod, Return, exec, $term"
        "$mainMod, D, exec, $menu"
        "$mainMod, B, exec, google-chrome-stable"
        "$mainMod, V, exec, vesktop"
        "$mainMod, E, exec, zed"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, F, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "SHIFT, Print, exec, grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        "CTRL, Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
