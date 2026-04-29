{ pkgs, ... }:

{
  services.postgresql.enable = false;

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
    ensureDatabases = [ "dev" ];
    ensureUsers = [{
      name = "dev";
      ensurePermissions = { "dev.*" = "ALL PRIVILEGES"; };
    }];
  };
}
