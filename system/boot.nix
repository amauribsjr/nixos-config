{ pkgs, ... }:

{
  boot = {
    # --- Bootloader (UEFI + systemd-boot) ---
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;  # não entupir /boot
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    # --- Kernel ---
    # Kernel "stable" do nixpkgs. Tiger Lake é totalmente suportado faz anos;
    # bleeding edge não traz benefício e aumenta risco de regressão.
    kernelPackages = pkgs.linuxPackages;

    # Sem parâmetros NVIDIA, óbvio. Evito tweaks de PSR/i915 não testados —
    # podem causar artefatos visuais em painéis específicos.
    kernelParams = [ ];

    # Limpa /tmp no boot (libera espaço/RAM).
    tmp.cleanOnBoot = true;

    # --- VM tweaks pra 8GB de RAM com zram ---
    kernel.sysctl = {
      # Com zram, "trocar pra swap" custa microssegundos (compressão zstd em
      # RAM). Encorajamos o kernel a fazer isso em vez de descartar caches
      # úteis. 180 é o valor recomendado pela documentação do Fedora pra
      # zram-based swap.
      "vm.swappiness" = 180;

      # Mantém caches de inodes/dentries por mais tempo na RAM.
      "vm.vfs_cache_pressure" = 50;

      # Espera mais antes de fazer flush de páginas sujas — junta escritas
      # em batches, SSD trabalha menos, bateria dura mais.
      "vm.dirty_writeback_centisecs" = 1500;

      # Tuning fino pra zram.
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
