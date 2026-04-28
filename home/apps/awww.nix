{ pkgs, config, ... }:

let
  wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper.png";
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
      ExecStartPost = "${pkgs.awww}/bin/awww img ${wallpaper} --transition-type fade";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}