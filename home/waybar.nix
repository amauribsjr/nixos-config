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
        format-muted = "󰝟 MUT";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        on-click = "pavucontrol";
        scroll-step = 5;
      };

      backlight = {
        format = "󰃞 {percent}%";
        on-scroll-up = "brightnessctl set 5%+";
        on-scroll-down = "brightnessctl set 5%-";
        tooltip = false;
      };

      battery = {
        states = { warning = 30; critical = 15; };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
        tooltip-format = "{timeTo}, {power}W";
      };

      network = {
        format-wifi = "󰤨 {essid}";
        format-ethernet = "󰈀 ETH";
        format-disconnected = "󰤭 OFF";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "alacritty -e nmtui";
      };

      cpu    = { format = "󰘚 {usage}%"; tooltip = false; interval = 5; };
      memory = { format = "󰍛 {}%"; interval = 5; };

      tray = {
        icon-size = 14;
        spacing = 6;
      };
    }];

    # ─── darkSEA ──────────────────────────────────────────────────────────
    style = ''
      @define-color bg0      #151f2e;
      @define-color bg1      #1c2a3a;
      @define-color bg2      #253548;
      @define-color fg0      #e8f2fc;
      @define-color fg1      #c8daea;
      @define-color fg2      #8ba7c7;
      @define-color accent   #4a9eca;
      @define-color accdim   #2d7aaa;
      @define-color red      #c0737a;
      @define-color amber    #c4a86a;
      @define-color green    #6a9e7f;
      @define-color purple   #8b7eb8;
      @define-color grey     #253548;

      * {
          border: none;
          font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono";
          font-size: 13px;
          font-weight: 600;
          min-height: 0;
      }

      window#waybar {
          background-color: @bg0;
          color: @fg1;
          border: 1px solid @accdim;
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
          color: @fg0;
          background-color: @accdim;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @bg2;
          color: @fg1;
      }

      #window      { color: @fg0; font-weight: bold; }
      #clock       { color: @accent; font-weight: bold; }
      #pulseaudio  { color: @fg1; }
      #backlight   { color: @amber; }
      #battery     { color: @green; }
      #battery.charging               { color: @accent; }
      #battery.warning:not(.charging) { color: @amber; }
      #battery.critical:not(.charging) {
          color: @red;
          animation: blink 1s steps(2) infinite;
      }
      #network     { color: @fg1; }
      #cpu         { color: @fg2; }
      #memory      { color: @purple; }

      #tray { padding: 0 8px; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      #pulseaudio:hover, #backlight:hover, #battery:hover,
      #network:hover, #cpu:hover, #memory:hover, #clock:hover {
          background-color: @bg2;
          border-radius: 4px;
          color: @fg1;
      }

      @keyframes blink {
          to { background-color: @red; color: @bg0; }
      }
    '';
  };
}
