{ pkgs, ... }:

{
  services.flatpak.enable = true;

  # Adiciona Flathub no primeiro boot. `--if-not-exists` é idempotente.
  system.activationScripts.flatpakFlathub = ''
    if [ -x ${pkgs.flatpak}/bin/flatpak ]; then
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists \
        flathub https://flathub.org/repo/flathub.flatpakrepo || true
    fi
  '';
}
