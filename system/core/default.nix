{ ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./packages.nix
    ../development/databases.nix
    ../development/virtualisation.nix
    ../development/nix-ld.nix
    ../development/flutter.nix
    ../development/redis.nix
  ];

  systemd.oomd = {
    enable             = true;
    enableRootSlice    = true;
    enableSystemSlice  = true;
    enableUserSlices   = true;
  };
}
