{ pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
    XDG_SESSION_TYPE = "wayland";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
  ];
}
