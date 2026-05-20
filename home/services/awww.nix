{ pkgs, config, theme, ... }:

let
  wallpaperFile = ../../wallpapers/${theme.wallpaper.default};
  wallpaperDefault =
    if builtins.pathExists wallpaperFile then
      "${config.home.homeDirectory}/Pictures/Wallpapers/${theme.wallpaper.default}"
    else
      throw "awww: default wallpaper '${theme.wallpaper.default}' doesn't exist in wallpapers/";
  wallpaperState = "${config.home.homeDirectory}/${theme.wallpaper.stateFile}";
  setWallpaper = pkgs.writeShellScript "set-wallpaper" ''
    current=""
    if [ -f "${wallpaperState}" ]; then
      name=$(cat "${wallpaperState}")
      target="${config.home.homeDirectory}/Pictures/Wallpapers/$name"
      if [ -f "$target" ]; then
        current="$target"
      fi
    fi

    if [ -z "$current" ] && [ -f "${wallpaperDefault}" ]; then
      current="${wallpaperDefault}"
    fi

    if [ -z "$current" ]; then
      exit 0
    fi

    for i in $(seq 1 30); do
      if ${pkgs.awww}/bin/awww img "$current" --transition-type fade; then
        exit 0
      fi
      sleep 0.2
    done
    exit 0
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