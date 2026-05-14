{ ... }:

{
  imports = [
    ./devtools.nix
    ./mobiletools.nix # temporary
    ./databases.nix
    ./virtualisation.nix
    ./nix-ld.nix
    ./redis.nix
  ];
}