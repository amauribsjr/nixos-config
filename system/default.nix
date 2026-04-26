{ ... }:

{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./audio.nix
    ./graphics.nix
    ./power.nix
    ./desktop.nix
    ./flatpak.nix
    ./virtualisation.nix
    ./nix.nix
    ./packages.nix
    ./users.nix
  ];

  system.stateVersion = "24.05";
}
