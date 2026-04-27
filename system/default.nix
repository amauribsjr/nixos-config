{ pkgs, ... }:

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
    ./databases.nix
    ./virtualisation.nix
    ./nix.nix
    ./packages.nix
    ./users.nix
  ];

  system.stateVersion = "24.05";

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

}
