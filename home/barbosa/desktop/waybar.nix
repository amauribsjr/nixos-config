{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    
    # Configuração 100% declarativa em Nix
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      
      modules-left = [ "hyprland/workspaces" "custom/sep" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ 
        "custom/spotify" 
        "custom/sep" 
        "pulseaudio" 
        "custom/sep" 
        "network" 
        "custom/sep" 
        "cpu" 
        "custom/sep" 
        "memory" 
        "custom/sep" 
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
      };

      clock = {
        format = "{:%H:%M | %Y-%m-%d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
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
        spacing = 8;
      };

      "custom/spotify" = {
        format = "{}";
        max-length = 40;
        interval = 5;
        exec = "~/.config/waybar/scripts/spotify.sh";
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

      "custom/sep" = {
        format = "|";
        tooltip = false;
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

      @define-color spotify #98971a;

      /* --- General --- */
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background-color: @bg;
          color: @fg;
          transition-property: background-color;
          transition-duration: .5s;
      }

      /* --- Workspaces --- */
      #workspaces button {
          padding: 0 14px;
          background-color: transparent;
          color: @fg-dim;
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

      /* --- Modules Base --- */
      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #custom-power,
      #custom-spotify,
      #tray,
      #window {
          padding: 0 14px;
          color: @fg;
      }

      /* --- Window Title --- */
      #window {
          color: @aqua;
          font-weight: normal;
      }

      /* --- Separator --- */
      #custom-sep {
          color: @gray;
          padding: 0 8px;
      }

      /* --- Clock --- */
      #clock {
          color: @fg;
          font-weight: bold;
      }

      /* --- Module Colors --- */
      #custom-spotify {
          color: @green;
          font-weight: bold;
          padding: 0 16px;
          margin-right: 8px;
      }

      #custom-spotify.paused {
          color: @gray;
      }

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
          padding: 0 10px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @red;
      }

      /* --- Power Button --- */
      #custom-power {
          color: @red;
          font-weight: bold;
          padding: 0 16px;
          margin-left: 4px;
      }

      #custom-power:hover {
          background-color: rgba(251, 73, 52, 0.15);
      }

      /* --- Hover Effects --- */
      #pulseaudio:hover,
      #network:hover,
      #cpu:hover,
      #memory:hover {
          background-color: @bg-light;
      }
    '';
  };
}
