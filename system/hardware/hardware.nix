{ config, lib, modulesPath, ... }:

let
  btrfsOpts = [
    "noatime"
    "compress=zstd:1"
    "discard=async"
  ];
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.supportedFilesystems = [ "btrfs" ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device  = "/dev/disk/by-label/NIXOS_ROOT";
    fsType  = "btrfs";
    options = btrfsOpts ++ [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device  = "/dev/disk/by-label/NIXOS_ROOT";
    fsType  = "btrfs";
    options = btrfsOpts ++ [ "subvol=@home" ];
  };

  fileSystems."/nix" = {
    device  = "/dev/disk/by-label/NIXOS_ROOT";
    fsType  = "btrfs";
    options = btrfsOpts ++ [ "subvol=@nix" ];
  };

  fileSystems."/var/log" = {
    device        = "/dev/disk/by-label/NIXOS_ROOT";
    fsType        = "btrfs";
    options       = btrfsOpts ++ [ "subvol=@log" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device  = "/dev/disk/by-label/NIXOS_BOOT";
    fsType  = "vfat";
    options = [ "umask=0077" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  services.btrfs.autoScrub = {
    enable      = true;
    interval    = "monthly";
    fileSystems = [ "/" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;
}