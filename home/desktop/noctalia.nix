{ colors, ... }: {

  programs.noctalia-shell = {
    enable = true;
    
    settings = {
      theme = {
        blur = true;
        palette = {
          accent = "${colors.accent}"; 
          background = "${colors.bg}";
          foreground = "${colors.fg}";
        };
      };

      bar = {
        position = "top";
        height = 36;
        widgets = [
          "niri/workspaces"
          "niri/window"
          "clock" 
          "battery" 
          "network" 
          "sys-monitor"
        ];
      };

      notifications.enable = true;
      osd.enable = true;
    };
  };
}