{ pkgs, ... }:

{
  # Em Wayland puro (sem services.xserver.enable), o driver KMS é carregado
  # direto pelo kernel (i915) — não precisamos de services.xserver.videoDrivers.

  hardware.graphics = {
    enable = true;
    enable32Bit = false;  # sem Wine/Steam: ~2GB a menos no store

    # VAAPI / aceleração de vídeo. O Pentium Gold 7505 carrega a marca
    # "Intel UHD Graphics" (não Iris Xe — não atende ao requisito de 96 EUs).
    # Mas a arquitetura é Xe-LP / Gen 12, mesmo silício, então os drivers
    # corretos são os de Tiger Lake:
    #   • intel-media-driver  → driver iHD (correto pra Broadwell+)
    #   • vpl-gpu-rt          → runtime QSV (Tiger Lake e mais novos)
    #   • libvdpau-va-gl      → ponte VDPAU→VAAPI (alguns players ainda pedem)
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";              # Chrome/Electron usam Wayland nativo
    LIBVA_DRIVER_NAME = "iHD";         # força o driver Intel novo
    XDG_SESSION_TYPE = "wayland";
    # Variáveis de cursor (tema definido no home-manager)
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # Utilitários pra debugar VAAPI quando algo não decodificar em hardware.
  environment.systemPackages = with pkgs; [
    libva
    libva-utils       # `vainfo` lista codecs disponíveis
  ];
}
