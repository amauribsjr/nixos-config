{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # Firewall on por padrão; libera nada além do mínimo.
    firewall.enable = true;
  };

  # NetworkManager-wait-online bloqueia o boot até a rede estar online (até
  # 30s). Inútil em laptop — o user já está logado antes disso terminar.
  systemd.services.NetworkManager-wait-online.enable = false;
}
