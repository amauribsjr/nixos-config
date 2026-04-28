{ config, pkgs, ... }:

let
  wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper.png";
in

{
  programs.niri.settings = {
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
    hotkey-overlay.skip-at-startup = true;

    input = {
      keyboard = {
        xkb = { layout = "br"; variant = "abnt2"; };
        repeat-delay = 300;
        repeat-rate = 35;
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true;
        click-method = "clickfinger";
        accel-profile = "adaptive";
        scroll-method = "two-finger";
      };
      mouse = { accel-profile = "flat"; };
      focus-follows-mouse = { enable = true; max-scroll-amount = "0%"; };
    };

    outputs."eDP-1" = {
      scale = 1.0;
      transform = { flipped = false; rotation = 0; };
      position = { x = 0; y = 0; };
    };

    layout = {
      gaps = 4;
      always-center-single-column = true;
      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];
      default-column-width = { proportion = 0.5; };
      preset-window-heights = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      focus-ring = {
        enable = true;
        width = 1;
        active.color = "#a86060";
        inactive.color = "#504945";
      };

      border.enable = false;
      background-color = "#282828";
    };

    spawn-at-startup = [
      { command = [ "sh" "d9bb6a-c" "${pkgs.awww}/bin/awww-daemon & sleep 1 && [ -f '${wallpaper}' ] && ${pkgs.awww}/bin/awww img '${wallpaper}' --transition-type fade || true" ]; }      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
     #{ command = [ "${pkgs.mako}/bin/mako" ]; }
      { command = [ "${pkgs.networkmanagerapplet}/bin/nm-applet" "--indicator" ]; }
    ];

    environment = {
      DISPLAY = ":0";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };

    window-rules = [
      {
        matches = [
          { app-id = "^org\\.gnome\\.PolkitAuthAgent.*"; }
          { app-id = "^pavucontrol$"; }
          { app-id = "^blueman-manager$"; }
        ];
        open-floating = true;
      }

      {
        geometry-corner-radius = {
          top-left = 0.0;
          top-right = 0.0;
          bottom-left = 0.0;
          bottom-right = 0.0;
        };
        clip-to-geometry = true;
      }

    ];

    animations.enable = true;

    binds = with config.lib.niri.actions; {
      "Mod+Return".action  = spawn "alacritty";
      "Mod+D".action       = spawn "fuzzel";
      "Mod+B".action       = spawn "google-chrome-stable";
      "Mod+V".action       = spawn "vesktop";
      "Mod+E".action       = spawn "zeditor";
      "Mod+T".action       = spawn "nautilus";

      "Mod+Q".action            = close-window;
      "Mod+F".action            = fullscreen-window;
      "Mod+M".action            = maximize-column;
      "Mod+Ctrl+F".action       = expand-column-to-available-width;
      "Mod+Shift+F".action      = toggle-window-floating;
      "Mod+Shift+C".action      = center-column;
      "Mod+R".action            = switch-preset-column-width;
      "Mod+Shift+R".action      = switch-preset-window-height;
      "Mod+W".action            = toggle-column-tabbed-display;

      "Mod+Left".action  = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action    = focus-window-or-workspace-up;
      "Mod+Down".action  = focus-window-or-workspace-down;
      "Mod+H".action     = focus-column-left;
      "Mod+L".action     = focus-column-right;
      "Mod+K".action     = focus-window-or-workspace-up;
      "Mod+J".action     = focus-window-or-workspace-down;

      "Mod+Shift+Left".action  = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action    = move-window-up;
      "Mod+Shift+Down".action  = move-window-down;
      "Mod+Shift+H".action     = move-column-left;
      "Mod+Shift+L".action     = move-column-right;
      "Mod+Shift+K".action     = move-window-up;
      "Mod+Shift+J".action     = move-window-down;

      "Mod+BracketLeft".action  = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+Minus".action       = set-column-width "-10%";
      "Mod+Equal".action       = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      "Mod+Shift+1".action.move-column-to-workspace = [ 1 ];
      "Mod+Shift+2".action.move-column-to-workspace = [ 2 ];
      "Mod+Shift+3".action.move-column-to-workspace = [ 3 ];
      "Mod+Shift+4".action.move-column-to-workspace = [ 4 ];
      "Mod+Shift+5".action.move-column-to-workspace = [ 5 ];
      "Mod+Shift+6".action.move-column-to-workspace = [ 6 ];
      "Mod+Shift+7".action.move-column-to-workspace = [ 7 ];
      "Mod+Shift+8".action.move-column-to-workspace = [ 8 ];
      "Mod+Shift+9".action.move-column-to-workspace = [ 9 ];

      "Mod+O".action           = toggle-overview;
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Print".action      = { screenshot = {}; };
      "Ctrl+Print".action = { screenshot-screen = {}; };
      "Alt+Print".action  = { screenshot-window = {}; };

      "XF86AudioRaiseVolume" = { action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; allow-when-locked = true; };
      "XF86AudioLowerVolume" = { action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; allow-when-locked = true; };
      "XF86AudioMute"        = { action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; allow-when-locked = true; };
      "XF86AudioMicMute"     = { action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; allow-when-locked = true; };
      "XF86AudioPlay".action = spawn "playerctl" "play-pause";
      "XF86AudioNext".action = spawn "playerctl" "next";
      "XF86AudioPrev".action = spawn "playerctl" "previous";

      "XF86MonBrightnessUp"   = { action = spawn "brightnessctl" "set" "5%+"; allow-when-locked = true; };
      "XF86MonBrightnessDown" = { action = spawn "brightnessctl" "set" "5%-"; allow-when-locked = true; };

      "Mod+Alt+L" = { action = spawn "swaylock" "-f" "-c" "282828"; allow-when-locked = true; };
      "Mod+Shift+E".action = quit;
      "Mod+Shift+P".action = power-off-monitors;

      "Mod+WheelScrollDown" = { action = focus-column-right; cooldown-ms = 150; };
      "Mod+WheelScrollUp"   = { action = focus-column-left;  cooldown-ms = 150; };

      "Mod+Escape" = { action = toggle-keyboard-shortcuts-inhibit; allow-inhibiting = false; };
    };
  };
}
