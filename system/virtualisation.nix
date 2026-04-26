{ ... }:

{
  # Docker pra estudo (containers de banco, etc.). Em 8GB de RAM, atenção:
  # use `docker stats` e desligue o que não precisa.
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
