{ ... }:
{
  imports = [
    ./nix.nix
    ./locale.nix
    ./networking.nix
    ./users.nix
    ./packages.nix
    ./virtualisation.nix
    ./databases.nix
    ./nix-ld.nix
  ];

  systemd.oomd = {
    enable             = true;
    enableRootSlice    = true;
    enableSystemSlice  = true;
    enableUserSlices   = true;
  };
}
