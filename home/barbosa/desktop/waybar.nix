{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 40;
      margin-top = 8;
      margin-left = 12;
      margin-right = 12;

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
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = " Online";
        format-disconnected = " Offline";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      cpu = {
        format = " {usage}%";
        tooltip = false;
      };

      memory = {
        format = " {}%";
      };

      tray = {
        icon-size = 18;
        spacing = 10;
      };

      "custom/spotify" = {
        format = " {}";
        max-length = 40;
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
        format = " ";
        tooltip = false;
        on-click = "~/.config/waybar/scripts/power.sh";
      };
    }];

    style = ''
      /* --- Gruvbox Dark Soft Palette --- */
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

      /* --- Reset Base --- */
      * {
          border: none;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 15px;
          min-height: 0;
      }

      /* --- Main Window --- */
      window#waybar {
          background-color: transparent;
          color: @fg;
      }

      /* --- Float Islands --- */
      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #tray,
      #custom-spotify,
      #custom-power {
          background-color: @bg;
          padding: 0 16px;
          margin: 0;
      }

      /* --- Left Island --- */
      #workspaces {
          background-color: @bg;
          border-radius: 12px 0 0 12px;
          padding: 0 4px;
          margin-right: 0;
      }

      #window {
          background-color: @bg;
          border-radius: 0 12px 12px 0;
          padding: 0 16px;
          margin-left: 0;
          color: @aqua;
          font-weight: normal;
      }

      #window.empty {
          background-color: transparent;
          padding: 0;
          margin: 0;
      }

      /* --- Workspaces --- */
      #workspaces button {
          padding: 4px 12px;
          margin: 4px 2px;
          background-color: transparent;
          color: @fg-dim;
          border-radius: 8px;
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

      /* --- Mid Island --- */
      #clock {
          background-color: @bg;
          border-radius: 12px;
          padding: 0 24px;
          color: @fg;
          font-weight: bold;
          font-size: 16px;
      }

      /* --- Right Island --- */
      #custom-spotify {
          background-color: @bg;
          border-radius: 12px 0 0 12px;
          color: @green;
          font-weight: bold;
          padding: 0 16px;
      }

      #custom-spotify.paused {
          color: @gray;
      }

      #custom-power {
          background-color: @bg;
          border-radius: 0 12px 12px 0;
          color: @red;
          font-weight: bold;
          padding: 0 16px;
      }

      #custom-power:hover {
          background-color: rgba(251, 73, 52, 0.15);
      }

      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #tray {
          border-left: 1px solid rgba(235, 219, 178, 0.1);
      }

      /* --- Modules --- */
      #pulseaudio {
          color: @aqua;
      }

      #network {
          color: @green;
      }

      #cpu {
          color: @yellow;
      }

      #memory {
          color: @purple;
      }

      #tray {
          padding: 0 12px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @red;
      }

      /* --- Hover Effects --- */
      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover,
      #clock:hover {
          background-color: @bg-light;
      }

      /* --- Animations --- */
      #workspaces button,
      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #custom-spotify,
      #custom-power {
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      }
    '';
  };
}
