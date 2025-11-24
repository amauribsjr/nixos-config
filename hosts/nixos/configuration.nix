{ config, pkgs, lib, inputs, ... }:

{
  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # --- Time & Locales ---
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # --- Input ---
  console.keyMap = "us-acentos";
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # --- Display Manager ---
  services.xserver.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # --- Hyprland ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  programs.dconf.enable = true;

  # --- Audio (Pipewire) ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # --- Shell & Prompt (ZSH + Starship) ---
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # --- User ---
  users.users.barbosa = {
    isNormalUser = true;
    description = "barbosa";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "audio" ];
  };

  # --- Programs ---
  programs.ssh.startAgent = true;
  nixpkgs.config.allowUnfree = true;

  # --- Fonts ---
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
    # Core utilities
    vim
    wget
    git
    btop
    wl-clipboard

    # System tools
    bibata-cursors
    spotify
    playerctl
    psmisc
    fastfetch

    # WM essentials
    tuigreet
    pavucontrol

    # Apps
    google-chrome
    vesktop

    # Dev - Editors
    zed-editor
    vscode

    # Dev - Languages/Build
    jdk21
    rustc
    cargo
    gcc
    gnumake

    # Dev - DB Tools
    dbeaver-bin
    mariadb
  ];

  # --- XDG Portals ---
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      hyprland = {
        default = lib.mkForce [ "gtk" "hyprland" ];
      };
    };
  };

  # --- Nix Settings ---
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # --- Garbage Collection ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05";
}
