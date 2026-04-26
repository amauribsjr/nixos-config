{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Módulos de kernel necessários no initrd para detectar NVMe e USB no boot.
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"  # leitor SD do Inspiron
  ];
  boot.initrd.kernelModules = [ ];

  # KVM da Intel (Tiger Lake-U).
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # --- Filesystems ---
  # Particionamento esperado (ver INSTALL.md):
  #   nvme0n1p1: vfat,  label=NIXOS_BOOT (512 MiB)
  #   nvme0n1p2: ext4,  label=NIXOS_ROOT (resto)
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_ROOT";
    fsType = "ext4";
    # noatime: não reescreve atime a cada read. Reduz drasticamente as
    # escritas no SSD com ~zero efeito prático no Linux moderno.
    options = [ "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS_BOOT";
    fsType = "vfat";
    # umask=0077: ESP só legível pelo root (boa prática de segurança;
    # algumas chaves/bootloaders deixam credenciais ali).
    options = [ "umask=0077" ];
  };

  # --- Swap ---
  # Sem swap em disco; usamos zramSwap (configurado em ./power.nix).
  # Trade-off: hibernate (suspend-to-disk) deixa de funcionar.
  swapDevices = [ ];

  # --- Hardware básico ---
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;
}
