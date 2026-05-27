{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    networkmanagerapplet
    polkit_gnome
    grim
    slurp
    swappy
    yazi
    jq
    fd
    ripgrep
    chafa
    fastfetch
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick
    wofi

    google-chrome
    spotify
    vesktop
    obs-studio

    dbeaver-bin
    bruno
    zed-editor

    gnome-calculator
    gnome-text-editor

    prismlauncher
    protonup-qt
    steamtinkerlaunch
    gamescope
  ];
}