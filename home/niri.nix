{ config, pkgs, ... }:

{
  # =========================================================================
  # Niri — scrollable-tiling Wayland compositor
  # =========================================================================
  # Configurado via niri-flake's home module (programs.niri.settings).
  # Vantagens vs editar config.kdl manualmente:
  #   • Validação em build-time — config quebrada = falha no nixos-rebuild
  #   • config.lib.niri.actions expõe todas as ações como funções Nix tipadas
  #   • Schema sincronizado com a versão do niri instalada

  programs.niri.settings = {
    # ─── Prefer-no-CSD ───────────────────────────────────────────────────
    # Pede aos clients pra omitir client-side decorations. Niri desenha
    # focus-ring AROUND windows que aceitarem (visual mais consistente).
    prefer-no-csd = true;

    # ─── Screenshots ─────────────────────────────────────────────────────
    screenshot-path = "~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";

    # ─── Hotkey overlay ──────────────────────────────────────────────────
    hotkey-overlay.skip-at-startup = true;

    # ─── Input ────────────────────────────────────────────────────────────
    input = {
      keyboard = {
        xkb = {
          layout = "br";
          variant = "abnt2";
        };
        repeat-delay = 300;
        repeat-rate = 35;
      };

      touchpad = {
        tap = true;                       # tap-to-click
        natural-scroll = true;
        dwt = true;                       # disable while typing
        click-method = "clickfinger";     # 1=L, 2=R, 3=M (sem áreas físicas)
        accel-profile = "adaptive";       # melhor que flat pra touchpad
        scroll-method = "two-finger";
      };

      mouse = {
        accel-profile = "flat";           # mouse externo: sem aceleração
      };

      # Foco segue o mouse — produtivo em scrollable-tiling.
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";         # não rola pra trás se cruza borda
      };
    };

    # ─── Outputs (monitor) ────────────────────────────────────────────────
    # eDP-1 é o nome convencional do painel embarcado. Confirme depois com
    # `niri msg outputs`.
    #
    # NOTA: mode propositalmente omitido. Em 1366x768 há um único mode
    # disponível, e niri auto-seleciona o melhor. Definir manualmente exige
    # que o refresh rate bata EXATO até 3 decimais com o que niri reporta
    # (ex: 60.000 vs 59.987) — uma fonte clássica de tela preta. Se quiser
    # forçar, descomente após confirmar com `niri msg outputs`:
    #   mode = { width = 1366; height = 768; refresh = 60.000; };
    outputs."eDP-1" = {
      scale = 1.0;
      transform = {
        flipped = false;
        rotation = 0;
      };
      position = { x = 0; y = 0; };
    };

    # ─── Layout ───────────────────────────────────────────────────────────
    layout = {
      # Gaps reduzidos pra tela 1366x768 (espaço é precioso).
      gaps = 6;

      # Centraliza janela única quando só tem 1 coluna na workspace.
      always-center-single-column = true;

      # Larguras de coluna que `Mod+R` cicla: 1/3, 1/2, 2/3.
      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      # Largura padrão de novas janelas: 50%.
      default-column-width = { proportion = 0.5; };

      # Alturas de janela que `Mod+Shift+R` cicla.
      preset-window-heights = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#4a9eca";
        inactive.color = "#253548";
      };

      border.enable = false;
      background-color = "#151f2e";
    };

    # ─── Spawn at startup ─────────────────────────────────────────────────
    # IMPORTANTE: comandos passam pelo niri spawn (não pelo shell), então
    # cada arg é literal. Usamos paths absolutos via Nix string interpolation
    # pra garantir que o binário está no PATH (niri spawn não herda o PATH
    # do shell do usuário).
    spawn-at-startup = [
      { command = [ "${pkgs.swaybg}/bin/swaybg" "-i" "/home/barbosa/Pictures/wallpaper.png" "-m" "fill" ]; }
      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
      { command = [ "${pkgs.mako}/bin/mako" ]; }
      { command = [ "${pkgs.networkmanagerapplet}/bin/nm-applet" "--indicator" ]; }
      # xwayland-satellite é integrado out-of-the-box desde niri 25.08
      # — sobe sob demanda quando algum app X11 for spawned.
    ];

    # ─── Environment variables exportadas pra apps spawned pelo niri ──
    environment = {
      DISPLAY = ":0";  # consumido pelo xwayland-satellite
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };

    # ─── Window rules ─────────────────────────────────────────────────────
    window-rules = [
      # Janelas pequenas (auth dialogs, controles) abrem flutuando.
      {
        matches = [
          { app-id = "^org\\.gnome\\.PolkitAuthAgent.*"; }
          { app-id = "^pavucontrol$"; }
          { app-id = "^blueman-manager$"; }
        ];
        open-floating = true;
      }

      # Cantos arredondados em todas as janelas.
      {
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-left = 8.0;
          bottom-right = 8.0;
        };
        clip-to-geometry = true;
      }
    ];

    # ─── Animations ───────────────────────────────────────────────────────
    # Mantenho ON — niri tem animações otimizadas (~negligíveis no Gen 12 Xe-LP).
    animations.enable = true;

    # ═════════════════════════════════════════════════════════════════════
    # KEYBINDS — atalhos clássicos, intuitivos, com gestos do touchpad
    # ═════════════════════════════════════════════════════════════════════
    binds = with config.lib.niri.actions; {
      # ─── Apps ───────────────────────────────────────────────────────────
      "Mod+Return".action  = spawn "alacritty";              # terminal (clássico)
      "Mod+D".action       = spawn "fuzzel";                  # launcher
      "Mod+B".action       = spawn "google-chrome-stable";   # browser
      "Mod+V".action       = spawn "vesktop";                 # discord
      "Mod+E".action       = spawn "zeditor";              # editor
      "Mod+T".action       = spawn "nautilus";                  # file manager

      # ─── Window management ──────────────────────────────────────────────
      "Mod+Q".action            = close-window;                # fechar
      "Mod+F".action            = fullscreen-window;           # fullscreen toggle
      "Mod+M".action            = maximize-column;             # MAXIMIZE COLUMN
      "Mod+Ctrl+F".action       = expand-column-to-available-width;  # expandir pro espaço livre
      "Mod+Shift+F".action      = toggle-window-floating;      # floating toggle
      "Mod+Shift+C".action      = center-column;               # centralizar coluna

      # Toggle entre presets (1/3, 1/2, 2/3).
      "Mod+R".action            = switch-preset-column-width;
      "Mod+Shift+R".action      = switch-preset-window-height;

      # Tabs (várias janelas empilhadas como abas no mesmo column).
      "Mod+W".action            = toggle-column-tabbed-display;

      # ─── Focus (Vim-style + setas) ─────────────────────────────────────
      "Mod+Left".action    = focus-column-left;
      "Mod+Right".action   = focus-column-right;
      "Mod+Up".action      = focus-window-or-workspace-up;
      "Mod+Down".action    = focus-window-or-workspace-down;
      "Mod+H".action       = focus-column-left;
      "Mod+L".action       = focus-column-right;
      "Mod+K".action       = focus-window-or-workspace-up;
      "Mod+J".action       = focus-window-or-workspace-down;

      # ─── Mover janelas/colunas ─────────────────────────────────────────
      "Mod+Shift+Left".action  = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action    = move-window-up;
      "Mod+Shift+Down".action  = move-window-down;
      "Mod+Shift+H".action     = move-column-left;
      "Mod+Shift+L".action     = move-column-right;
      "Mod+Shift+K".action     = move-window-up;
      "Mod+Shift+J".action     = move-window-down;

      # ─── Consumir/expelir janelas em colunas ───────────────────────────
      # Niri-específico: junta janelas numa mesma coluna (empilhadas) ou
      # separa em colunas distintas. Bracket = direção visual.
      "Mod+BracketLeft".action  = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      # ─── Resize column manualmente ─────────────────────────────────────
      "Mod+Minus".action   = set-column-width "-10%";
      "Mod+Equal".action   = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      # ─── Workspaces (1-9, 0=10) ─────────────────────────────────────────
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      # Mover coluna pra workspace.
      # Sintaxe especial (lista) workaround pro issue #944 do niri-flake.
      "Mod+Shift+1".action.move-column-to-workspace = [ 1 ];
      "Mod+Shift+2".action.move-column-to-workspace = [ 2 ];
      "Mod+Shift+3".action.move-column-to-workspace = [ 3 ];
      "Mod+Shift+4".action.move-column-to-workspace = [ 4 ];
      "Mod+Shift+5".action.move-column-to-workspace = [ 5 ];
      "Mod+Shift+6".action.move-column-to-workspace = [ 6 ];
      "Mod+Shift+7".action.move-column-to-workspace = [ 7 ];
      "Mod+Shift+8".action.move-column-to-workspace = [ 8 ];
      "Mod+Shift+9".action.move-column-to-workspace = [ 9 ];

      # ─── Overview (vista geral de workspaces) ──────────────────────────
      "Mod+O".action          = toggle-overview;

      # ─── Hotkey overlay (cheat-sheet de atalhos) ─────────────────────
      # Mod+? em layouts US é Shift+/. Em ABNT2, "?" está em outra tecla,
      # mas niri procura "Slash" como key latina, então funciona igual.
      # Mantemos o default do niri (Mod+Shift+Slash).
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      # ─── Screenshots ──────────────────────────────────────────────────
      "Print".action            = { screenshot = {}; };
      "Ctrl+Print".action       = { screenshot-screen = {}; };
      "Alt+Print".action        = { screenshot-window = {}; };

      # ─── Áudio (teclas de função) ──────────────────────────────────────
      "XF86AudioRaiseVolume" = {
        action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        allow-when-locked = true;
      };

      # ─── Mídia (player) ────────────────────────────────────────────────
      "XF86AudioPlay".action = spawn "playerctl" "play-pause";
      "XF86AudioNext".action = spawn "playerctl" "next";
      "XF86AudioPrev".action = spawn "playerctl" "previous";

      # ─── Brilho ────────────────────────────────────────────────────────
      "XF86MonBrightnessUp" = {
        action = spawn "brightnessctl" "set" "5%+";
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = spawn "brightnessctl" "set" "5%-";
        allow-when-locked = true;
      };

      # ─── Lock / Power ──────────────────────────────────────────────────
      "Mod+Alt+L" = {
        action = spawn "swaylock" "-f" "-c" "151f2e";
        allow-when-locked = true;
      };
      "Mod+Shift+E".action = quit;                       # sai (volta pro greeter)
      "Mod+Shift+P".action = power-off-monitors;

      # ─── Mod+Scroll mouse → trocar coluna ──────────────────────────────
      "Mod+WheelScrollDown" = {
        action = focus-column-right;
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action = focus-column-left;
        cooldown-ms = 150;
      };

      # ─── Escape: toggle keyboard inhibit (escape de apps que captam tudo) ─
      "Mod+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };
    };
  };

  # =========================================================================
  # GESTOS DE TOUCHPAD (ativos por padrão no niri, sem precisar configurar)
  # =========================================================================
  # • 3-dedos vertical    → trocar workspace (cima/baixo)
  # • 3-dedos horizontal  → mover scroll horizontal pelos columns
  # • 4-dedos vertical    → toggle overview
  # • Top-left hot corner → toggle overview
  #
  # Estes gestos são built-in. Não precisamos configurar nada.
}
