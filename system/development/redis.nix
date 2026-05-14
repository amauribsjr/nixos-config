{ lib, ... }:

{
  services.redis.servers.dev = {
    enable = true;
    port = 6379;
    bind = "127.0.0.1";
    save = [];
  };

  services.redis.vmOverCommit = true;
  systemd.services.redis-dev.wantedBy = lib.mkForce [];
}