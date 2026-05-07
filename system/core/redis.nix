{ ... }:

{
  services.redis = {
    vmOverCommit = true;

    servers.dev = {
      enable = true;
      bind = "127.0.0.1";
      port = 6379;
      openFirewall = false;
      databases = 16;

      save = [
        [ 900 1 ]
        [ 300 10 ]
        [ 60 10000 ]
      ];

      appendOnly = false;
      appendFsync = "everysec";

      settings = {
        protected-mode = "yes";
        maxmemory = "256mb";
        maxmemory-policy = "allkeys-lru";
      };
    };
  };
}