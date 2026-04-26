{ ... }:

{
  # rtkit permite ao pipewire elevar prioridade real-time.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;  # sem jogos 32-bit, economiza ~espaço
    pulse.enable = true;
    jack.enable = true;
  };
}
