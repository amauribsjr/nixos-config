{ ... }:

{
  services.redis = {
    vmOverCommit = true;
    servers.dev = {
      enable = false;
    };
  };
}
