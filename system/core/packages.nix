{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    btop
    htop
    wl-clipboard
    zip
    unzip
    file
    tree

    bibata-cursors
    playerctl
    psmisc
    fastfetch
    pciutils
    usbutils
    brightnessctl
    pamixer
    powertop
    lm_sensors
    intel-gpu-tools
    nautilus
    eog
    pavucontrol
    google-chrome
    vesktop
    obs-studio
    vlc
    spotify
    gnome-software

    zed-editor
    vscode

    jdk21
    maven
    rustup
    #rust-analyzer
    #clippy
    #rustfmt
    gcc
    gnumake
    pkg-config

    nil

    dbeaver-bin
    sqlite
  ];

  services.gvfs.enable = true;

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';

}
