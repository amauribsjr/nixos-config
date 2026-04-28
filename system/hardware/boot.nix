{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    kernelPackages = pkgs.linuxPackages;

    kernelParams = [ "acpi=force" ];

    tmp.cleanOnBoot = true;

    kernel.sysctl = {

      "vm.swappiness" = 180;

      "vm.vfs_cache_pressure" = 50;

      "vm.dirty_writeback_centisecs" = 1500;

      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
    DefaultTimeoutAbortSec = "10s";
  };
}
