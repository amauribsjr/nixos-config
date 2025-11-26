{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 44;
      margin-top = 8;
      margin-left = 12;
      margin-right = 12;
      spacing = 0;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [
        "custom/spotify"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "tray"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        on-click = "activate";
        format = "{name}";
      };

      "hyprland/window" = {
        max-length = 40;
        separate-outputs = true;
      };

      clock = {
        format = "{:%H:%M | %d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Muted";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = " Online";
        format-disconnected = " Offline";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      cpu = {
        format = " {usage}%";
        tooltip = false;
      };

      memory = {
        format = " {}%";
      };

      tray = {
        icon-size = 20;
        spacing = 10;
      };

      "custom/spotify" = {
        format = "{}";
        max-length = 35;
        interval = 5;
        exec = "~/.config/waybar/scripts/spotify.sh";
        exec-if = "pgrep spotify";
        on-click = "playerctl -p spotify play-pause";
        on-scroll-up = "playerctl -p spotify next";
        on-scroll-down = "playerctl -p spotify previous";
        return-type = "json";
        escape = true;
      };

      "custom/power" = {
        format = " ";
        tooltip = false;
        on-click = "~/.config/waybar/scripts/power.sh";
      };
    }];

    style = ''
      /* --- Catppuccin Mocha Palette --- */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;
      @define-color border    #45475a;

      * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 18px;
          min-height: 0;
      }

      window#waybar {
          background-color: rgba(30, 30, 46, 0.85);
          color: @text;
          border: 2px solid @border;
          border-radius: 6px;
      }

      #workspaces,
      #window,
      #clock,
      #custom-spotify,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #tray,
      #custom-power {
          background-color: transparent;
          padding: 0 12px;
          margin: 0;
          border-radius: 0;
          border: none;
      }

      /* Workspaces */
      #workspaces {
          padding: 0 6px;
      }

      #workspaces button {
          padding: 0 6px;
          margin: 0 3px;
          color: @subtext0;
          background-color: transparent;
          border-radius: 4px;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          color: @mauve;
          background-color: @surface0;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @surface0;
          color: @text;
      }

      #workspaces button.urgent {
          color: @red;
      }

      /* Text colors */
      #window { color: @lavender; }
      #clock { color: @text; font-weight: bold; }
      #custom-spotify { color: @green; }
      #pulseaudio { color: @blue; }
      #network { color: @sapphire; }
      #cpu { color: @yellow; }
      #memory { color: @peach; }
      #custom-power { color: @red; margin-right: 12px; }

      /* Tray adjustment */
      #tray {
          padding: 0 12px;
      }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      /* Unified hover */
      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover,
      #clock:hover,
      #custom-spotify:hover,
      #custom-power:hover {
          background-color: @surface0;
          border-radius: 4px;
      }
    '';
  };
}
