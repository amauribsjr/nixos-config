{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      margin-top = 4;
      margin-left = 8;
      margin-right = 8;
      spacing = 0;

      modules-left   = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right  = [ "pulseaudio" "backlight" "battery" "network" "cpu" "memory" "tray" ];

      "niri/workspaces" = { format = "{value}"; };
      "niri/window"     = { max-length = 40; separate-outputs = true; };

      clock = {
        format = "{:%H:%M | %d/%m}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Mute";
        format-icons.default = [ "" "" "" ];
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
        states = { warning = 30; critical = 15; };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged  = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        tooltip-format = "{timeTo}, {power}W";
      };

      network = {
        format-wifi        = "  {essid}";
        format-ethernet    = "  Wired";
        format-disconnected = "  Offline";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "alacritty -e nmtui";
      };

      cpu    = { format = " {usage}%"; tooltip = false; interval = 5; };
      memory = { format = " {}%"; interval = 5; };
      tray   = { icon-size = 14; spacing = 6; };
    }];

    # ─── darkSEA ───────────────────────────────────────────────────────────
    style = ''
      @define-color bg0    #1b2430;
      @define-color bg1    #222e3f;
      @define-color bg2    #2a3a4e;
      @define-color fg0    #d6e9ff;
      @define-color fg1    #88b4e7;
      @define-color fg2    #586f89;
      @define-color mint   #34febb;
      @define-color teal   #32ae85;
      @define-color blue   #88b4e7;
      @define-color slate  #5d8cc0;
      @define-color red    #e06b74;
      @define-color yellow #e5c07b;
      @define-color purple #a77bca;
      @define-color grey   #444c55;

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
          border: 1px solid @mint;
          border-radius: 4px;
          opacity: 0.96;
      }

      #workspaces, #window, #clock, #pulseaudio, #backlight,
      #battery, #network, #cpu, #memory, #tray {
          background-color: transparent;
          padding: 0 8px;
          margin: 0;
      }

      #workspaces { padding: 0 4px; }

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
          background-color: @mint;
          font-weight: bold;
      }

      #workspaces button:hover { background-color: @bg2; color: @fg0; }

      #window   { color: @fg0; font-weight: bold; }
      #clock    { color: @blue; font-weight: bold; }
      #pulseaudio { color: @mint; }
      #backlight  { color: @yellow; }
      #battery    { color: @teal; }
      #battery.charging               { color: @mint; }
      #battery.warning:not(.charging) { color: @yellow; }
      #battery.critical:not(.charging) {
          color: @red;
          animation: blink 1s steps(2) infinite;
      }
      #network { color: @blue; }
      #cpu     { color: @slate; }
      #memory  { color: @purple; }

      #tray { padding: 0 8px; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      #pulseaudio:hover, #backlight:hover, #battery:hover,
      #network:hover, #cpu:hover, #memory:hover, #clock:hover {
          background-color: @bg2;
          border-radius: 4px;
          color: @fg0;
      }

      @keyframes blink { to { background-color: @red; color: @bg0; } }
    '';
  };
}
