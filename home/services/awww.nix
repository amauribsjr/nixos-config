{ pkgs, config, theme, ... }:

let
  wallpaperDefault = "${config.home.homeDirectory}/Pictures/Wallpapers/${theme.wallpaper.default}";
  wallpaperState = "${config.home.homeDirectory}/${theme.wallpaper.stateFile}";

  setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
    if [ -f "${wallpaperState}" ]; then
      name=$(cat "${wallpaperState}")
      target="${config.home.homeDirectory}/Pictures/Wallpapers/$name"
      if [ -f "$target" ]; then
        ${pkgs.awww}/bin/awww img "$target" --transition-type fade
        exit 0
      fi
    fi
    [ -f "${wallpaperDefault}" ] && \
      ${pkgs.awww}/bin/awww img "${wallpaperDefault}" --transition-type fade
  '';
in
{
  systemd.user.services.awww = {
    Unit = {
      Description = "Awww wallpaper daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      ExecStartPost = "${setWallpaper}";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}