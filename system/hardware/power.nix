{ pkgs, ... }:

{
  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 50;
    priority      = 100;
  };

  services.fstrim.enable = true;

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC    = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_MIN_PERF_ON_AC            = 0;
      CPU_MAX_PERF_ON_AC            = 100;
      CPU_BOOST_ON_AC               = 1;
      CPU_HWP_DYN_BOOST_ON_AC       = 1;

      # CPU - BAT balanced
      CPU_SCALING_GOVERNOR_ON_BAT    = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT  = "balance_performance";
      CPU_MIN_PERF_ON_BAT            = 0;
      CPU_MAX_PERF_ON_BAT            = 90;
      CPU_BOOST_ON_BAT               = 1;
      CPU_HWP_DYN_BOOST_ON_BAT       = 1;

      # Thermal profile
      PLATFORM_PROFILE_ON_AC  = "balanced";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      # PCIe / runtime power
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_DRIVER_DENYLIST = "r8169";

      PCIE_ASPM_ON_AC  = "default";
      PCIE_ASPM_ON_BAT = "powersave";

      WIFI_PWR_ON_AC  = "off";
      WIFI_PWR_ON_BAT = "on";

      WOL_DISABLE = "Y";

      # Audio
      SOUND_POWER_SAVE_ON_AC      = 0;
      SOUND_POWER_SAVE_ON_BAT     = 1;
      SOUND_POWER_SAVE_CONTROLLER = "N";

      # USB
      USB_AUTOSUSPEND = 0;
    };
  };

  services.thermald.enable = true;

  services.fwupd.enable = true;
  systemd.timers.fwupd-refresh.enable = false;

  services.upower = {
    enable              = true;
    criticalPowerAction = "PowerOff";
    percentageLow       = 20;
    percentageCritical  = 8;
    percentageAction    = 5;
  };

  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
    settings = {
      General = {
        FastConnectable    = true;
        ReconnectAttempts  = 7;
        ReconnectIntervals = "1,2,4,8,16,32,64";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  systemd.services.bt-autoconnect = {
    description = "Auto-connect Bluetooth Pebble K380s";
    after       = [ "bluetooth.service" ];
    wants       = [ "bluetooth.service" ];
    wantedBy    = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStartPre = "/run/current-system/sw/bin/sleep 3";
      ExecStart = let
        script = pkgs.writeShellScript "bt-autoconnect" ''
          DEVICE="DF:04:7A:06:C4:C8"

          for i in $(seq 1 10); do
            ${pkgs.bluez}/bin/bluetoothctl show 2>/dev/null | grep -q "Powered: yes" && break
            sleep 1
          done

          ${pkgs.bluez}/bin/bluetoothctl trust "$DEVICE" 2>/dev/null
          ${pkgs.bluez}/bin/bluetoothctl connect "$DEVICE" 2>/dev/null || true
        '';
      in "${script}";
    };
  };

  services.blueman.enable = true;
}
