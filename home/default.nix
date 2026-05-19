{ pkgs, config, lib, ... }:

{
  imports = [
    ./packages.nix
    ./theme.nix
    ./shell.nix
  
    ./apps/kitty.nix
    ./apps/office.nix
    ./apps/wofi.nix
    ./apps/zed-theme.nix
  
    ./cli/fastfetch.nix
    ./cli/git.nix
  
    ./desktop/niri.nix
    ./desktop/waybar.nix
  
    ./services/awww.nix
    ./services/clipboard.nix
    ./services/gtklock.nix
    ./services/swayidle.nix
  ];

  home.username = "koppi";
  home.homeDirectory = "/home/koppi";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 3000;
      ignore-timeout = false;
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
  };

  home.file = builtins.listToAttrs (
    map (f: {
      name = "Pictures/Wallpapers/${f}";
      value.source = ../wallpapers/${f};
    }) (builtins.attrNames (lib.filterAttrs (_: type: type == "regular" || type == "symlink")
      (builtins.readDir ../wallpapers)))
  );

  home.activation.createExtraUserDirs =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.coreutils}/bin/mkdir -p \
        "${config.home.homeDirectory}/Pictures/Screenshots" \
        "${config.home.homeDirectory}/Pictures/Wallpapers"
    '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Media
      "video/mp4" = "vlc.desktop";
      "video/mkv" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
      "audio/ogg" = "vlc.desktop";
      "audio/flac" = "vlc.desktop";
      "audio/wav" = "vlc.desktop";

      # Images
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";
      "image/svg+xml" = "org.gnome.eog.desktop";

      # Text / code
      "text/plain" = "dev.zed.Zed.desktop";
      "text/markdown" = "dev.zed.Zed.desktop";
      "text/x-markdown" = "dev.zed.Zed.desktop";
      "text/x-nix" = "dev.zed.Zed.desktop";
  
      # Data/config files
      "application/json" = "dev.zed.Zed.desktop";
      "application/toml" = "dev.zed.Zed.desktop";
      "application/x-yaml" = "dev.zed.Zed.desktop";
      "text/yaml" = "dev.zed.Zed.desktop";
      "text/x-yaml" = "dev.zed.Zed.desktop";
      "application/xml" = "dev.zed.Zed.desktop";
      "text/xml" = "dev.zed.Zed.desktop";
  
      # Scripts
      "application/x-shellscript" = "dev.zed.Zed.desktop";
      "text/x-shellscript" = "dev.zed.Zed.desktop";
    };
  };
}