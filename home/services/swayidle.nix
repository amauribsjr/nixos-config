{ pkgs, ... }:

{
  systemd.user.services."swayidle-ac" = {
    Unit = {
      Description = "swayidle (AC profile)";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 600 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
          resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
          timeout 1800 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.gtklock}/bin/gtklock --daemonize' \
          lock '${pkgs.gtklock}/bin/gtklock --daemonize'
      '';
      Restart = "on-failure";
    };
  };

  systemd.user.services."swayidle-bat" = {
    Unit = {
      Description = "swayidle (BAT profile)";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 300 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
          resume '${pkgs.niri}/bin/niri msg action power-on-monitors' \
          timeout 600 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.gtklock}/bin/gtklock --daemonize' \
          lock '${pkgs.gtklock}/bin/gtklock --daemonize'
      '';
      Restart = "on-failure";
    };
  };

  systemd.user.services."swayidle-dispatcher" = {
    Unit = {
      Description = "Changes between AC/BAT profiles";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.writeShellScript "swayidle-dispatcher" ''
        set -u
        is_on_ac() {
          for d in /sys/class/power_supply/*/; do
            [ -r "$d/type" ] || continue
            [ "$(cat "$d/type")" = "Mains" ] || continue
            [ "$(cat "$d/online" 2>/dev/null)" = "1" ] && return 0
          done
          return 1
        }

        apply() {
          if is_on_ac; then
            ${pkgs.systemd}/bin/systemctl --user stop  swayidle-bat.service 2>/dev/null || true
            ${pkgs.systemd}/bin/systemctl --user start swayidle-ac.service
          else
            ${pkgs.systemd}/bin/systemctl --user stop  swayidle-ac.service  2>/dev/null || true
            ${pkgs.systemd}/bin/systemctl --user start swayidle-bat.service
          fi
        }

        apply
        ${pkgs.upower}/bin/upower --monitor | while read -r _; do apply; done
        exit 1
      ''}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}