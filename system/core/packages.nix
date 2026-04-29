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
    bibata-cursors
    gnome-disk-utility

    # Apps
    nautilus
    eog
    pavucontrol
    google-chrome
    vesktop
    obs-studio
    vlc
    mpv
    spotify
    gnome-software
    pandoc

    # Editors
    vscode

    # Java
    jdk21
    maven

    # Rust
    rustc
    cargo
    gcc
    gnumake
    pkg-config

    # C
    gdb

    # Haskell
    ghc
    cabal-install
    haskell-language-server

    # Ruby
    ruby
    rubyPackages.solargraph

    # Nix
    nixd

    # Databases
    dbeaver-bin
    sqlite

  ];

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=20M
    MaxRetentionSec=2week
  '';
}
