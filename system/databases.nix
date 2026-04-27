{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "dev" ];
    ensureUsers = [{
      name = "dev";
      ensureDBOwnership = true;
    }];
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
    ensureDatabases = [ "dev" ];
    ensureUsers = [{
      name = "dev";
      ensurePermissions = { "dev.*" = "ALL PRIVILEGES"; };
    }];
  };
}
