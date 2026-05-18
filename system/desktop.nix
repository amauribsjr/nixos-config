{ pkgs, fonts, theme, ... }:

{

  programs.niri.enable = true;
  services.displayManager.defaultSession = "niri";
  security.pam.services.gtklock = {
    enableGnomeKeyring = true;  # antes era apenas {}
  };
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;

  programs.seahorse.enable = true;
  
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/backlight/%k/brightness"
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

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
    jack.enable = true;
  };
}