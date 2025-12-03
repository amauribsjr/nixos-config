{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      margin-top = 6;
      margin-left = 10;
      margin-right = 10;
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
        max-length = 50;
        separate-outputs = true;
      };

      clock = {
        format = "{:%H:%M | %d/%m}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Mute";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = "  Wired";
        format-disconnected = "  Offline";
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
        format = " {}";
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
      @define-color bg0      #32302f;
      @define-color bg1      #3c3836;
      @define-color fg0      #d5c4a1;
      @define-color fg1      #ebdbb2;

      @define-color red      #ea6962;
      @define-color orange   #e78a4e;
      @define-color yellow   #d8a657;
      @define-color green    #a9b665;
      @define-color aqua     #89b482;
      @define-color blue     #7daea3;
      @define-color purple   #d3869b;
      @define-color grey     #928374;

      * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 15px;
          font-weight: 600;
          min-height: 0;
      }

      window#waybar {
          background-color: @bg0; 
          color: @fg0;
          border: 1px solid @aqua;
          border-radius: 4px;
          opacity: 0.96;
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
          padding: 0 10px;
          margin: 0;
      }

      #workspaces {
          padding: 0 4px;
      }

      #workspaces button {
          padding: 0 6px;
          margin: 0 2px;
          color: @grey;
          background-color: transparent;
          border-radius: 4px;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          color: @bg0;
          background-color: @orange;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @bg1;
          color: @fg1;
      }

      #workspaces button.urgent {
          color: @red;
      }

      #window { color: @fg1; font-weight: bold; }
      #clock { color: @blue; font-weight: bold; }
      
      #custom-spotify { color: @green; }
      #custom-spotify.paused { color: @grey; }

      #pulseaudio { color: @aqua; }
      #network { color: @purple; }
      #cpu { color: @red; }
      #memory { color: @yellow; }
      #custom-power { color: @red; margin-right: 10px; }

      #tray {
          padding: 0 10px;
      }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover,
      #clock:hover,
      #custom-spotify:hover,
      #custom-power:hover {
          background-color: @bg1;
          border-radius: 4px;
          color: @fg1;
      }
    '';
  };
}
