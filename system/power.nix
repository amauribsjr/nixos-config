{ ... }:

{
  # =========================================================================
  # zramSwap — swap comprimido em RAM
  # =========================================================================
  # Páginas frias são comprimidas com zstd em vez de irem pro SSD.
  # Em 8GB de RAM, taxa de compressão típica ~2.7× → "vira 12-14GB efetivos".
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;     # prioridade alta sobre qualquer outro swap
  };

  # =========================================================================
  # SSD — TRIM semanal
  # =========================================================================
  # Sem TRIM, performance de write cai com o tempo conforme blocos ficam
  # órfãos. Weekly em batch é mais conservador que `discard=async` (sem
  # latência durante uso normal).
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # =========================================================================
  # TLP — power management granular pra Tiger Lake
  # =========================================================================
  services.power-profiles-daemon.enable = false;  # conflita com TLP

  services.tlp = {
    enable = true;
    settings = {
      # ─── CPU governor (intel_pstate active mode) ─────────────────────────
      # Intel Core 6th gen+ usa intel_pstate que aceita SOMENTE "performance"
      # ou "powersave". "powersave" não significa "lento" — o firmware ainda
      # usa turbo dinamicamente. Em laptop modesto, sweet spot.
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # ─── Energy Performance Preference (HWP.EPP) ─────────────────────────
      # Tuning fino: diz à CPU o quanto priorizar performance vs eficiência.
      # Da mais agressiva à mais econômica:
      #   performance > balance_performance > default > balance_power > power
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # ─── Turbo Boost ──────────────────────────────────────────────────────
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      # HWP Dynamic Boost (Tiger Lake suporta).
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      # ─── Limites de % de performance ──────────────────────────────────────
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      # ─── Platform profile (firmware-level hint) ───────────────────────────
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # ─── Runtime PM (autosuspend de devices PCIe ociosos) ─────────────────
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # ─── PCIe Active State Power Management ───────────────────────────────
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";   # L1.2, máxima economia

      # ─── WiFi power saving ────────────────────────────────────────────────
      WIFI_PWR_ON_AC = "off";   # latência menor pra dev
      WIFI_PWR_ON_BAT = "on";   # economiza ~0.5W

      # ─── Wake-on-LAN (off, economiza standby) ────────────────────────────
      WOL_DISABLE = "Y";

      # ─── Audio codec power saving ────────────────────────────────────────
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      # ─── USB autosuspend ──────────────────────────────────────────────────
      USB_AUTOSUSPEND = 1;

      # ─── Battery Care Thresholds (opcional, depende do hardware) ─────────
      # Pra confirmar suporte, depois de instalado:
      #   ls /sys/class/power_supply/BAT0/charge_control_*
      # Se aparecer charge_control_start_threshold e _end_threshold,
      # descomente as duas linhas pra prolongar a vida da bateria
      # (carrega entre 75-80%):
      # START_CHARGE_THRESH_BAT0 = 75;
      # STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # =========================================================================
  # Thermal management
  # =========================================================================
  services.thermald.enable = true;

  # =========================================================================
  # Firmware updates (Dell publica firmware no LVFS)
  # =========================================================================
  # Após instalar, rode: fwupdmgr refresh && fwupdmgr update
  services.fwupd.enable = true;

  # =========================================================================
  # Bateria & sensores via dbus
  # =========================================================================
  services.upower = {
    enable = true;
    # Sem swap em disco, hibernate falharia. Desliga em vez de tentar.
    criticalPowerAction = "PowerOff";
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 3;
  };

  # =========================================================================
  # Bluetooth
  # =========================================================================
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;   # liga manualmente (`bluetoothctl power on`)
  };
  services.blueman.enable = true;
}
