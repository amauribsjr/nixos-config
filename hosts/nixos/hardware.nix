{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  #LABEL VERSION (FUTURE UPDATE)
  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/NIXOS_ROOT";
  #   fsType = "ext4";
  # };
  #
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-label/NIXOS_BOOT";
  #   fsType = "vfat";
  # };
  #
  # swapDevices = [{
  #   device = "/dev/disk/by-label/NIXOS_SWAP";
  # }];

  #CURRENT SYSTEM
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fa57f289-4eeb-495c-9238-63b57adf5269";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/486B-E851";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/dbe0302e-1453-4afb-80fa-c77af5b60443"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
