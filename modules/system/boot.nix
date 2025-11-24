{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ 
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" 
    ];
  };
}
