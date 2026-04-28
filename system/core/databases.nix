{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "dev" ];
    ensureUsers = [{
      name = "dev";
      ensureDBOwnership = true;
    }];
    authentication = ''
      local all all trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128 trust
    '';
  };

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
