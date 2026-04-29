{ ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    controlMaster  = "auto";
    controlPath    = "~/.ssh/master-%r@%h:%p";
    controlPersist = "10m";
    compression = true;

    extraConfig = ''
      KexAlgorithms      curve25519-sha256@libssh.org,curve25519-sha256
      Ciphers            chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
      MACs               hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
      HostKeyAlgorithms  ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256
    '';

    matchBlocks = {
      "github.com" = {
        hostname       = "github.com";
        user           = "git";
        identityFile   = "~/.ssh/id_ed25519_github";
        identitiesOnly = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}