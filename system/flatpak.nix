{ pkgs, ... }:

{
  services.flatpak.enable = true;

  system.activationScripts.flatpakFlathub = ''
    if [ -x ${pkgs.flatpak}/bin/flatpak ]; then
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists \
        flathub https://flathub.org/repo/flathub.flatpakrepo || true
    fi
  '';
}
