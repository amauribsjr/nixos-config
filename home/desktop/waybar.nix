{ pkgs, colors, fonts, ... }:

let
power-menu = pkgs.writeShellScript "power-menu" ''
  chosen=$(printf "Power off\nReboot\nSuspend\nLogout" | wofi --dmenu \
    --width=180 --height=200 --location=center \
    --style="$HOME/.config/wofi/center.css")
  if echo "$chosen" | grep -q "Power off"; then
    systemctl poweroff
  elif echo "$chosen" | grep -q "Reboot"; then
    systemctl reboot
  elif echo "$chosen" | grep -q "Suspend"; then
    systemctl suspend
  elif echo "$chosen" | grep -q "Logout"; then
    niri msg action quit
  fi
'';
in

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        layer    = "top";
        position = "top";
        height   = 24;
        margin-top   = 0;
        margin-left  = 0;
        margin-right = 0;
        spacing  = 0;

        modules-left   = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right  = [
          "pulseaudio"
          "battery"
          "custom/kb"
          "tray"
          "custom/power"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "일";
            "2" = "이";
            "3" = "삼";
            "4" = "사";
            "5" = "오";
            "6" = "육";
            "7" = "칠";
            "8" = "팔";
            "9" = "구";
          };
        };

        "niri/window" = {
          max-length      = 40;
          separate-outputs = true;
        };

        clock = {
          format         = "{:%I:%M %p | %d/%m}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        pulseaudio = {
          format       = "{icon} {volume}%";
          format-muted = "󰝟 MUT";
          format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
          on-click     = "pavucontrol";
          scroll-step  = 5;
        };

        battery = {
          states          = { warning = 25; critical = 10; };
          format          = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged  = "󰚥 {capacity}%";
          format-icons    = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
          tooltip-format  = "{timeTo}, {power}W";
        };

        tray = {
          icon-size = 14;
          spacing   = 6;
        };

        "custom/power" = {
          format   = "⏻";
          on-click = "${power-menu}";
          tooltip  = false;
        };
      }
    ];

    style = ''
      @define-color bg0     #${colors.bg};
      @define-color bg1     #${colors.bg1};
      @define-color bg2     #${colors.bg2};
      @define-color bg3     #${colors.bg3};
      @define-color bg4     #${colors.bg4};
      @define-color fg0     #${colors.fg};
      @define-color fg1     #${colors.fg1};
      @define-color fg2     #${colors.fg2};
      @define-color accent  #${colors.accent};
      @define-color accdim  #${colors.accdim};
      @define-color red     #${colors.red};
      @define-color amber   #${colors.byellow};
      @define-color green   #${colors.green};
      @define-color purple  #${colors.magenta};
      @define-color blue    #${colors.blue};
      @define-color grey    #${colors.bg4};

      * {
          border: none;
          font-family: "${fonts.mono}", "${fonts.symbols}";
          font-size: ${toString fonts.waybarSize}px;
          font-weight: 600;
          min-height: 0;
      }

      window#waybar.top {
          background-color: @bg0;
          color: @fg1;
          opacity: 0.96;
      }

      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #battery,
      #tray,
      #custom-power,
      #taskbar {
          background-color: transparent;
          padding: 0 8px;
          margin: 0;
      }

      #workspaces { padding: 0 4px; }

      #workspaces button {
          padding: 0 6px;
          margin: 0 1px;
          color: @grey;
          background-color: transparent;
          border-radius: 0;
          font-size: 12px;
      }

      #workspaces button.focused,
      #workspaces button.active {
          color: @bg0;
          background-color: @accent;
          font-weight: bold;
      }

      #workspaces button:hover {
          background-color: @bg2;
          color: @fg1;
      }

      #window        { color: @fg2; font-weight: bold; }
      #clock         { color: @accent; font-weight: bold; }
      #pulseaudio    { color: @fg1; }
      #battery       { color: @green; }
      #battery.charging               { color: @green; }
      #battery.warning:not(.charging) { color: @amber; }
      #battery.critical:not(.charging) {
          color: @red;
          animation: blink 2s steps(1) infinite;
      }
      #tray       { padding: 0 8px; }
      #tray > .passive          { -gtk-icon-effect: dim; }
      #tray > .needs-attention  { -gtk-icon-effect: highlight; background-color: @red; }

      #custom-power {
          color: @red;
          padding: 0 10px;
      }
      #custom-power:hover { background-color: @bg2; }

      #pulseaudio:hover, #battery:hover, #clock:hover {
          background-color: @bg2;
          color: @fg1;
      }

      @keyframes blink {
          to { background-color: @red; color: @bg0; }
      }
    '';
  };
}
