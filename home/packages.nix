{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Wayland & desktop
    awww
    networkmanagerapplet
    polkit_gnome

    # Theme
    gruvbox-gtk-theme

    # Screenshots
    grim
    slurp
    swappy

    # Terminal utilities
    yazi
    jq
    fd
    ripgrep
    chafa

    # Cláudio
    claude-code

    # File & media
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick

    # Launchers
    wofi

    # Apps
    google-chrome
    vesktop
    obs-studio
    dbeaver-bin
    bruno
    redis

  ];
}
