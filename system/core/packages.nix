{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CLI
    vim
    wget
    curl
    git
    lazygit
    file
    tree
    zip
    unzip
    p7zip

    # System & hardware
    btop
    htop
    fastfetch
    powertop
    lm_sensors
    pciutils
    usbutils
    intel-gpu-tools
    psmisc

    # Desktop
    wl-clipboard
    brightnessctl
    pamixer
    playerctl
    gnome-disk-utility
    xkb-switch

    # Apps
    nautilus
    eog
    pavucontrol
    vlc
    mpv
    pandoc
    zed-editor

    # Java
    jdk21
    maven

    # Rust
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    gcc
    gnumake
    pkg-config

    # C
    gdb

    # Nix
    nixd
    nixfmt
    statix
    deadnix
    nh
    nvd

    # Databases
    sqlite
  ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';
}
