{ pkgs, colors, config, lib, ... }:

{
  imports = [
    ./desktop/niri.nix
    ./desktop/waybar.nix
    ./packages.nix
    ./theme.nix
    ./shell.nix
    ./apps/alacritty.nix
    ./apps/wofi.nix
    ./cli/fastfetch.nix
    ./services/awww.nix
    ./cli/git.nix
    ./apps/helix.nix
  ];

  home.username    = "koppi";
  home.homeDirectory = "/home/koppi";
  home.stateVersion  = "24.05";

  programs.home-manager.enable = true;

  systemd.user.services."swayidle-ac" = {
    Unit = {
      Description = "swayidle (AC profile)";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 600  '${pkgs.niri}/bin/niri msg action power-off-monitors' \
          resume       '${pkgs.niri}/bin/niri msg action power-on-monitors' \
          timeout 1800 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}' \
          lock         '${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}'
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
          resume      '${pkgs.niri}/bin/niri msg action power-on-monitors' \
          timeout 600 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}' \
          lock         '${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}'
      '';
      Restart = "on-failure";
    };
  };

  systemd.user.services."swayidle-dispatcher" = {
    Unit = {
      Description = "Changes between AC/BAT profiles";
      PartOf = [ "graphical-session.target" ];
      After  = [ "graphical-session.target" ];
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
      ''}";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 3000;
      ignore-timeout  = false;
    };
  };

  xdg.userDirs = {
    enable              = true;
    createDirectories   = true;
    setSessionVariables = false;
  };

  home.file = builtins.listToAttrs (
    map (f: {
      name = "Pictures/Wallpapers/${f}";
      value.source = ../wallpapers/${f};
    }) (builtins.attrNames (builtins.readDir ../wallpapers))
  );
  
  home.activation.createExtraUserDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.coreutils}/bin/mkdir -p \
        "${config.home.homeDirectory}/Pictures/Screenshots" \
        "${config.home.homeDirectory}/Pictures/Wallpapers"
    '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4"        = "vlc.desktop";
      "video/mkv"        = "vlc.desktop";
      "video/webm"       = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "audio/mpeg"       = "vlc.desktop";
      "audio/ogg"        = "vlc.desktop";
      "audio/flac"       = "vlc.desktop";
      "audio/wav"        = "vlc.desktop";
      "image/png"        = "org.gnome.eog.desktop";
      "image/jpeg"       = "org.gnome.eog.desktop";
      "image/gif"        = "org.gnome.eog.desktop";
      "image/webp"       = "org.gnome.eog.desktop";
      "image/svg+xml"    = "org.gnome.eog.desktop";
    };
  };
}
