{ ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      # Pentium Gold 7505 = 2c/4t. Limitar paralelismo evita OOM ao compilar
      # pacotes pesados em 8GB de RAM.
      max-jobs = 2;
      cores = 2;
    };

    # Optimise periódica do store (auto-optimise-store já dedupa em tempo
    # real; isso aqui faz uma passagem completa pra pegar o que escapou).
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    # Garbage collection mais agressivo: SSD de 128GB é apertado.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # NOTA: o cache binário do niri (niri.cachix.org) é adicionado AUTOMATICAMENTE
  # pelo módulo niri.nixosModules.niri (opção `niri-flake.cache.enable`,
  # default true). Não declaramos manualmente pra evitar erros de digitação
  # de chave pública.

  nixpkgs.config.allowUnfree = true;
}
