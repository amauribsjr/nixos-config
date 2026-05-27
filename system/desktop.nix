{ pkgs, fonts, theme, ... }:

{
  programs.niri.enable = true;
  services.displayManager.defaultSession = "niri";
  security.pam.services.gtklock = {
    enableGnomeKeyring = true;
  };

  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10ec", ATTR{class}=="0x020000", ATTR{power/control}="on"
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];

    config.common.default = [ "gtk" ];
    config.niri = {
      default = [ "gnome" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };
  };

  programs.dconf.enable = true;
  fonts = {
    packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-color-emoji
      pkgs.liberation_ttf
      pkgs.font-awesome
      theme.fontPackages.ui
      theme.fontPackages.mono
      theme.fontPackages.syms
    ];

    fontconfig.defaultFonts = {
      monospace = [ fonts.systemMono fonts.symbols ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs: with pkgs; [
        mesa
        libGL
        libva
        intel-media-driver
        libvdpau
      ];
    };
  };

  programs.gamemode.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}