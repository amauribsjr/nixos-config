{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      margin-top = 6;
      margin-left = 10;
      margin-right = 10;

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
        format = "{:%H:%M}";
        format-alt = "{:%Y-%m-%d}";
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
        icon-size = 16;
        spacing = 8;
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

      @define-color bg-alpha  #1e1e2ecc;
      @define-color border   #45475a;
      
     * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background-color: transparent;
          color: @text;
      }

      /* --- Left Island (Workspaces + Window) --- */
      #workspaces {
          background-color: @bg-alpha;
          border-radius: 10px 0 0 10px;
          border: 1px solid @border;
          border-right: none;
          padding: 0 4px;
          margin-right: 0;
      }

      #workspaces button {
          padding: 2px 10px;
          margin: 4px 2px;
          background-color: transparent;
          color: @subtext0;
          border-radius: 6px;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          background-color: @surface1;
          color: @mauve;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @surface0;
          color: @text;
      }

      #workspaces button.urgent {
          background-color: @red;
          color: @base;
      }

      #window {
          background-color: @bg-alpha;
          border-radius: 0 10px 10px 0;
          border: 1px solid @border;
          border-left: none;
          padding: 0 14px;
          margin-left: 0;
          color: @lavender;
      }

      #window.empty {
          background-color: transparent;
          border: none;
      }

      /* --- Mid Island (Clock) --- */
      #clock {
          background-color: @bg-alpha;
          border: 1px solid @border;
          border-radius: 10px;
          padding: 0 20px;
          color: @text;
          font-weight: bold;
      }

      /* --- Right Island A (Spotify) --- */
      #custom-spotify {
          background-color: @bg-alpha;
          border: 1px solid @border;
          border-radius: 10px;
          color: @green;
          font-weight: bold;
          padding: 0 14px;
          margin-right: 8px;
      }

      #custom-spotify.paused {
          color: @subtext0;
      }

      /* --- Right Island B (Status Group) --- */
      #pulseaudio {
          background-color: @bg-alpha;
          border: 1px solid @border;
          border-right: none;
          border-radius: 10px 0 0 10px;
          padding: 0 10px 0 14px;
          color: @blue;
      }

      /* Mid */
      #network,
      #cpu,
      #memory,
      #tray {
          background-color: @bg-alpha;
          border-top: 1px solid @border;
          border-bottom: 1px solid @border;
          padding: 0 12px;
      }

      #network { color: @sapphire; }
      #cpu     { color: @yellow; }
      #memory  { color: @peach; }

      /* Divs */
      #network, #cpu, #memory, #tray {
         border-left: 1px solid rgba(255, 255, 255, 0.05);
      }

      #tray {
          padding: 0 10px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @red;
      }

      #custom-power {
          background-color: @bg-alpha;
          border: 1px solid @border;
          border-left: 1px solid rgba(255, 255, 255, 0.05);
          border-radius: 0 10px 10px 0;
          color: @red;
          font-weight: bold;
          padding: 0 14px 0 10px;
          margin-left: 0;
      }

      #custom-power:hover {
          background-color: @surface1;
      }

      /* HOVER EFFECTS */
      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover,
      #clock:hover {
          background-color: @surface0;
      }
    '';
  };
}
