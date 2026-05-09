{ pkgs, lib, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    port = 5432;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      local all all trust
      host  all all 127.0.0.1/32 trust
    '';
    initialScript = pkgs.writeText "pg-init.sql" ''
      CREATE USER dev WITH PASSWORD 'dev';
      CREATE DATABASE dev OWNER dev;
    '';
  };

  systemd.services.postgresql.wantedBy = lib.mkForce [];

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
    settings.mysqld.port = 3308;
  };

  systemd.services.mysql.wantedBy = lib.mkForce [];

  environment.systemPackages = [ pkgs.sqlite ];
}