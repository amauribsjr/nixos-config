{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    swaylock
    mako
    grim
    slurp
    swappy
    wl-clipboard
    networkmanagerapplet
    xwayland-satellite
    xdg-user-dirs

    yazi
    ffmpegthumbnailer
    unar
    poppler-utils
    imagemagick
    jq
    fd
    ripgrep
    fzf
    zoxide
    wofi 
  ];
}
