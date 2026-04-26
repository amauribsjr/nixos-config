{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    # Niri-flake recomenda systemd.enable=true (mas pode hit restart-limit
    # default — solução é resetar via spawn-at-startup ou desabilitar).
    # Como já estamos lançando waybar via niri spawn-at-startup, desligamos.
    systemd.enable = false;

    settings = [{
      layer = "top";              # niri-flake recomenda explicitamente
      position = "top";
      height = 30;
      margin-top = 4;
      margin-left = 8;
      margin-right = 8;
      spacing = 0;

      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "battery"
        "network"
        "cpu"
        "memory"
        "tray"
      ];

      "niri/workspaces" = {
        format = "{value}";
      };

      "niri/window" = {
        max-length = 40;
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
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
        scroll-step = 5;
      };

      backlight = {
        format = "{icon} {percent}%";
        format-icons = [ "" "" "" "" "" ];
        on-scroll-up = "brightnessctl set 5%+";
        on-scroll-down = "brightnessctl set 5%-";
        tooltip = false;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        tooltip-format = "{timeTo}, {power}W";
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = "  Wired";
        format-disconnected = "  Offline";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "alacritty -e nmtui";
      };

      cpu = {
        format = " {usage}%";
        tooltip = false;
        interval = 5;
      };

      memory = {
        format = " {}%";
        interval = 5;
      };

      tray = {
        icon-size = 14;
        spacing = 6;
      };
    }];

    # ─── Tema Gruvbox Soft Dark (mesmo da config anterior, consistência) ─
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
          font-size: 13px;
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
      #pulseaudio,
      #backlight,
      #battery,
      #network,
      #cpu,
      #memory,
      #tray {
          background-color: transparent;
          padding: 0 8px;
          margin: 0;
      }

      #workspaces {
          padding: 0 4px;
      }

      #workspaces button {
          padding: 0 5px;
          margin: 0 2px;
          color: @grey;
          background-color: transparent;
          border-radius: 4px;
      }

      #workspaces button.focused,
      #workspaces button.active {
          color: @bg0;
          background-color: @orange;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @bg1;
          color: @fg1;
      }

      #window      { color: @fg1; font-weight: bold; }
      #clock       { color: @blue; font-weight: bold; }
      #pulseaudio  { color: @aqua; }
      #backlight   { color: @yellow; }
      #battery     { color: @green; }
      #battery.charging               { color: @aqua; }
      #battery.warning:not(.charging) { color: @orange; }
      #battery.critical:not(.charging) {
          color: @red;
          animation: blink 1s steps(2) infinite;
      }
      #network     { color: @purple; }
      #cpu         { color: @red; }
      #memory      { color: @yellow; }

      #tray { padding: 0 8px; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      #pulseaudio:hover, #backlight:hover, #battery:hover,
      #network:hover, #cpu:hover, #memory:hover, #clock:hover {
          background-color: @bg1;
          border-radius: 4px;
          color: @fg1;
      }

      @keyframes blink {
          to { background-color: @red; color: @bg0; }
      }
    '';
  };
}
