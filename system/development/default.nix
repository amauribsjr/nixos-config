{ ... }:

{
  imports = [
    ./devtools.nix
    ./mobiletools.nix
    ./databases.nix
    ./virtualisation.nix
    ./nix-ld.nix
    ./redis.nix
  ];
}