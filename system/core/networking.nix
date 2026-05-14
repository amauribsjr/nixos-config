{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      extraCommands = ''
        iptables -A INPUT -s 172.16.0.0/12 -p tcp -m multiport --dports 3306,6379,8080 -j ACCEPT
      '';
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}