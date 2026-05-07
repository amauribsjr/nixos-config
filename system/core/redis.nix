{ ... }:

{
  services.redis = {
    vmOverCommit = true;
    servers.dev = {
      enable = true;
      bind = "127.0.0.1";
      port = 6379;
    };
  };
}
