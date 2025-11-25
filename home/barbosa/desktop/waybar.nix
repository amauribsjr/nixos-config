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
        format = " {}";
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
      @define-color bg #32302f;
      @define-color bg-light #3c3836;
      @define-color fg #ebdbb2;
      @define-color fg-dim #d5c4a1;

      @define-color red #fb4934;
      @define-color green #b8bb26;
      @define-color yellow #fabd2f;
      @define-color blue #83a598;
      @define-color purple #d3869b;
      @define-color aqua #8ec07c;
      @define-color orange #fe8019;
      @define-color gray #928374;

      * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background-color: transparent;
          color: @fg;
      }

      /* Left Island - Workspaces + Window */
      #workspaces {
          background-color: @bg;
          border-radius: 4px 0 0 4px;
          padding: 0 4px;
          margin-right: 0;
      }

      #workspaces button {
          padding: 2px 10px;
          margin: 2px 2px;
          background-color: transparent;
          color: @fg-dim;
          border-radius: 3px;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          background-color: @fg-dim;
          color: @bg;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @bg-light;
          color: @fg;
      }

      #workspaces button.urgent {
          background-color: @red;
          color: @bg;
      }

      #window {
          background-color: @bg;
          border-radius: 0 4px 4px 0;
          padding: 0 14px;
          margin-left: 0;
          color: @aqua;
      }

      #window.empty {
          background-color: transparent;
          padding: 0;
          margin: 0;
      }

      /* Center Island - Clock */
      #clock {
          background-color: @bg;
          border-radius: 4px;
          padding: 0 20px;
          color: @fg;
          font-weight: bold;
      }

      /* Right Island - Spotify (separate) */
      #custom-spotify {
          background-color: @bg;
          border-radius: 4px;
          color: @green;
          font-weight: bold;
          padding: 0 14px;
          margin-right: 8px;
      }

      #custom-spotify.paused {
          color: @gray;
      }

      /* Right Island - Other modules */
      #pulseaudio {
          background-color: @bg;
          border-radius: 4px 0 0 4px;
          padding: 0 14px;
          color: @aqua;
      }

      #network,
      #cpu,
      #memory,
      #tray {
          background-color: @bg;
          padding: 0 14px;
      }

      #network {
          color: @green;
          border-left: 1px solid rgba(235, 219, 178, 0.1);
      }

      #cpu {
          color: @yellow;
          border-left: 1px solid rgba(235, 219, 178, 0.1);
      }

      #memory {
          color: @purple;
          border-left: 1px solid rgba(235, 219, 178, 0.1);
      }

      #tray {
          padding: 0 10px;
          border-left: 1px solid rgba(235, 219, 178, 0.1);
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @red;
      }

      #custom-power {
          background-color: @bg;
          border-radius: 0 4px 4px 0;
          color: @red;
          font-weight: bold;
          padding: 0 14px;
          margin-left: 0;
      }

      #custom-power:hover {
          background-color: rgba(251, 73, 52, 0.15);
      }

      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover,
      #clock:hover {
          background-color: @bg-light;
      }
    '';
  };
}
