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

    plymouth = {
      enable = true;
      theme = "breeze";
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    };

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    tmp.cleanOnBoot = true;

    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.dirty_expire_centisecs" = 6000;
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 15;
      "vm.page-cluster" = 0;
    };
  };

  systemd.services."systemd-vconsole-setup".enable = false;
  systemd.settings.Manager = {
    DefaultTimeoutAbortSec = "10s";
  };
}
