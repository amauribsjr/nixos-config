{ ... }:

{
  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 100;
    priority      = 100;
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_BAT = 1;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 1;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "quiet";

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_DRIVER_DENYLIST = "r8169";

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "default";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      WOL_DISABLE = "Y";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "N";

      USB_AUTOSUSPEND = 1;
    };
  };

  services.thermald.enable = true;

  services.fwupd.enable = true;
  systemd.timers.fwupd-refresh.enable = false;

  services.upower = {
    enable = true;
    criticalPowerAction = "PowerOff";
    percentageLow = 15;
    percentageCritical = 5;
    percentageAction = 3;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
