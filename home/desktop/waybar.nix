{ pkgs, colors, fonts, ... }:

let
  power-menu = pkgs.writeShellScript "power-menu" ''
    chosen=$(printf "󰐥  Shutdown\n󰜉  Reboot\n󰒲  Suspend\n󰍃  Logout" | fuzzel --dmenu --lines=4 --width=20)
    case "$chosen" in
      *"Shutdown")  systemctl shutdown ;;
      *"Reboot") systemctl reboot ;;
      *"Suspend") systemctl suspend ;;
      *"Logout")    niri msg action quit ;;
    esac
  '';
in

{
  programs.waybar = {
    enable = true;

    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;
      spacing = 0;

      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "battery"
        "network"
        /* "cpu" */
        /* "memory" */
        "tray"
        "custom/power"
      ];

      "niri/workspaces" = {
        format = "{value}";
      };

      "niri/window" = {
        max-length = 30;
        separate-outputs = true;
      };

      clock = {
        format = "{:%I:%M %p | %d/%m}";
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
        states = { warning = 25; critical = 10; };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󰚥 {capacity}%";
        format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
        tooltip-format = "{timeTo}, {power}W";
      };

      "custom/power" = {
        format = "⏻";
        on-click = "${power-menu}";
        tooltip = false;
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

    style = ''
      @define-color bg0     #${colors.bg};
      @define-color bg1     #${colors.bg1};
      @define-color bg2     #${colors.bg2};
      @define-color fg0     #${colors.fg};
      @define-color fg1     #${colors.fg1};
      @define-color fg2     #${colors.fg2};
      @define-color accent  #${colors.fg1};
      @define-color accdim  #${colors.bg4};
      @define-color red     #${colors.bred};
      @define-color amber   #${colors.byellow};
      @define-color green   #${colors.bcyan};
      @define-color purple  #${colors.bmagenta};
      @define-color grey    #${colors.bg2};
      @define-color windows #${colors.accent};

      * {
          border: none;
          font-family: "${fonts.mono}", "${fonts.symbols}";
          font-size: ${toString fonts.waybarSize}px;
          font-weight: 600;
          min-height: 0;
      }

      window#waybar {
          background-color: @bg0;
          color: @fg1;
          border-bottom: 1px solid @accdim;
          border-radius: 0px;
          opacity: 0.96;
      }

      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #backlight,
      #battery,
      #network,
      /* #cpu, */
      /* #memory, */
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
          border-radius: 0px;
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

      #custom-power {
          color: @red;
          padding: 0 10px;
      }

      #custom-power:hover {
          background-color: @bg2;
      }

      #window      { color: @green; font-weight: bold; }
      #clock       { color: @accent; font-weight: bold; }
      #pulseaudio  { color: @fg1; }
      #backlight   { color: @amber; }
      #battery     { color: @green; }
      #battery.charging               { color: @green; }
      #battery.warning:not(.charging) { color: @amber; }
      #battery.critical:not(.charging) {
          color: @red;
          animation: blink 2s steps(1) infinite;
      }
      #network     { color: @purple; }
      #cpu         { color: @fg2; }
      #memory      { color: @purple; }

      #tray { padding: 0 8px; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @red; }

      #pulseaudio:hover, #backlight:hover, #battery:hover,
      #network:hover, #cpu:hover, #memory:hover, #clock:hover {
          background-color: @bg2;
          border-radius: 0px;
          color: @fg1;
      }

      @keyframes blink {
          to { background-color: @red; color: @bg0; }
      }
    '';
  };
}
