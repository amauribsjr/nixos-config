{ pkgs, colors, ... }:

{
  imports = [
    ./desktop/niri.nix
    ./desktop/waybar.nix
    ./packages.nix
    ./theme.nix
    ./shell.nix
    ./apps.nix
  ];

  home.username    = "koppi";
  home.homeDirectory = "/home/koppi";
  home.stateVersion  = "24.05";

  programs.home-manager.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 600;  command = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}";
      lock         = "${pkgs.swaylock}/bin/swaylock -f -c ${colors.bg}";
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
