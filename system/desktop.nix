{ pkgs, ... }:

{

  programs.niri.enable = true;
  services.displayManager.defaultSession = "niri";
  services.gvfs.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10ec", ATTR{class}=="0x020000", ATTR{power/control}="on"
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
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

  # Audio
  security.rtkit.enable = true;

  services.pipewire = {
    enable           = true;
    alsa.enable      = true;
    alsa.support32Bit = false;
    pulse.enable     = true;
    jack.enable      = true;
  };

  # Flatpak
  services.flatpak.enable = true;

  system.activationScripts.flatpakFlathub = ''
    if [ -x ${pkgs.flatpak}/bin/flatpak ]; then
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists \
        flathub https://flathub.org/repo/flathub.flatpakrepo || true
    fi
  '';
}
