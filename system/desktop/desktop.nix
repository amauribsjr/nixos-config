{ pkgs, ... }:

{
  programs.niri.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.displayManager.defaultSession = "niri";
  services.gvfs.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"

    ACTION=="add", SUBSYSTEM=="sound", ATTRS{idVendor}=="0a67", ATTRS{idProduct}=="d061", ENV{SYSTEMD_WANTS}=""
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
}
