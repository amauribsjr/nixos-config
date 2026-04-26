{ pkgs, ... }:

{
  # =========================================================================
  # Niri (compositor scrollable-tiling Wayland)
  # =========================================================================
  # Esse módulo (vindo do niri-flake) faz a integração system-level:
  # systemd target, polkit agent, dbus activation, etc. A configuração
  # propriamente dita do niri (binds, layout, etc.) está em home/niri.nix.
  programs.niri.enable = true;

  # =========================================================================
  # Greeter (SDDM)
  # =========================================================================
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.defaultSession = "niri";

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  # =========================================================================
  # XDG Portals
  # =========================================================================
  # IMPORTANTE: o niri-flake (programs.niri.enable=true) JÁ instala e
  # configura xdg-desktop-portal-gnome automaticamente — necessário pra
  # screencasting. Adicionamos apenas o portal GTK como fallback, pra apps
  # GTK não-GNOME (Thunar, file pickers de Flatpaks, etc.) terem suporte
  # completo de file-chooser e settings.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # niri-flake declara o portal default como "gnome" automaticamente.
    # Não sobrescrevemos pra evitar conflito.
  };

  # dconf é necessário pra muitos apps GTK.
  # (niri-flake também já habilita isso, mas declarar explicitamente
  # documenta a intenção.)
  programs.dconf.enable = true;

  # =========================================================================
  # Fonts
  # =========================================================================
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans       # Hangul (estudo de coreano), CJK em geral
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
}
