{ pkgs, config, colors, fonts, ... }:

let
  wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper.png";
in
{
  # Awww
  systemd.user.services.awww = {
    Unit = {
      Description = "Awww wallpaper daemon";
      After   = [ "graphical-session.target" ];
      PartOf  = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart     = "${pkgs.awww}/bin/awww-daemon";
      ExecStartPost = "${pkgs.awww}/bin/awww img ${wallpaper} --transition-type fade";
      Restart       = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Fastfetch
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "nixos_small",
        "padding": { "top": 1, "right": 3 }
      },
      "display": {
        "separator": "  "
      },
      "modules": [
        { "type": "title",  "format": "{user-name}@{host-name}" },
        { "type": "separator", "string": "──────" },
        { "type": "host",   "key": "host  ", "keyColor": "magenta" },
        { "type": "os",     "key": "os    ", "keyColor": "cyan" },
        { "type": "kernel", "key": "kernel", "keyColor": "yellow" },
        { "type": "cpu",    "key": "cpu   ", "keyColor": "red", "format": "{name}" },
        { "type": "memory", "key": "mem   ", "keyColor": "green" },
        { "type": "disk",   "key": "disk  ", "keyColor": "214", "folders": "/" }
      ]
    }
  '';

  # Wofi
  home.file.".config/wofi/config".text = ''
    no_actions=true
    insensitive=true
    hide_scroll=true
    matching=fuzzy
    allow_images=false
    allow_markup=false
    layer=top
  '';

  home.file.".config/wofi/center.css".text = ''
    window {
      background-color: #${colors.bg};
      font-family: "${fonts.mono}";
      border: 1px solid #${colors.fg1};
    }

    #input {
      background-color: #${colors.bg};
      color: #${colors.fg2};
      border: none;
      border-bottom: 1px solid #${colors.bg2};
      border-radius: 0;
      padding: 12px 20px;
      margin: 0;
      outline: none;
      box-shadow: none;
      font-size: 14px;
    }

    #input:focus {
      color: #${colors.fg};
      border-bottom: 1px solid #${colors.fg1};
    }

    #scroll { margin: 0; padding: 0; }
    #inner-box { background-color: transparent; }
    #outer-box { background-color: transparent; padding: 0; margin: 0; }

    #entry {
      padding: 10px 20px;
      border-radius: 0;
      background-color: transparent;
    }

    #entry:selected { background-color: #${colors.bg1}; }

    #text {
      color: #${colors.fg2};
      font-size: 14px;
    }

    #entry:selected #text { color: #${colors.fg}; }
  '';

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity       = 0.94;
        padding       = { x = 12; y = 12; };
        decorations   = "none";
        startup_mode  = "Windowed";
      };

      font = {
        normal = { family = fonts.mono; };
        bold   = { family = fonts.mono; };
        italic = { family = fonts.mono; };
        size   = fonts.size;
      };

      colors = {
        primary   = { background = "#${colors.bg}";  foreground = "#${colors.fg}"; };
        cursor    = { text       = "#${colors.bg}";  cursor     = "#${colors.fg}"; };
        selection = { text       = "#${colors.fg}";  background = "#${colors.bg2}"; };
        normal = {
          black   = "#${colors.black}";
          red     = "#${colors.red}";
          green   = "#${colors.green}";
          yellow  = "#${colors.yellow}";
          blue    = "#${colors.blue}";
          magenta = "#${colors.magenta}";
          cyan    = "#${colors.cyan}";
          white   = "#${colors.white}";
        };
        bright = {
          black   = "#${colors.bblack}";
          red     = "#${colors.bred}";
          green   = "#${colors.bgreen}";
          yellow  = "#${colors.byellow}";
          blue    = "#${colors.bblue}";
          magenta = "#${colors.bmagenta}";
          cyan    = "#${colors.bcyan}";
          white   = "#${colors.bwhite}";
        };
      };

      cursor    = { style = { shape = "Block"; blinking = "On"; }; unfocused_hollow = true; };
      selection.save_to_clipboard = true;
      scrolling = { history = 10000; multiplier = 3; };
    };
  };

  # Zed
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "dockerfile"
      "make"
      "rose-pine"
      "java"
      "haskell"
      "ruby"
    ];

    userSettings = {
      theme = { mode = "dark"; light = "Rosé Pine Dawn"; dark = "Rosé Pine Moon"; };

      ui_font_family     = fonts.mono;
      ui_font_size       = 14;
      buffer_font_family = fonts.mono;
      buffer_font_size   = 13;
      buffer_line_height = "comfortable";

      tab_size              = 4;
      hard_tabs             = false;
      preferred_line_length = 100;
      soft_wrap             = "none";
      relative_line_numbers = false;
      cursor_blink          = true;
      show_whitespaces      = "selection";
      indent_guides         = { enabled = true; line_width = 1; };

      format_on_save                     = "off";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save       = true;

      vim_mode      = false;
      tab_bar       = { show = true; };
      scrollbar     = { show = "auto"; };
      project_panel = { dock = "left"; default_width = 240; };

      git = {
        git_gutter   = "tracked_files";
        inline_blame = { enabled = true; delay_ms = 1000; };
      };

      terminal = {
        font_family    = fonts.mono;
        font_size      = 14;
        shell          = { program = "zsh"; };
        copy_on_select = true;
      };

      telemetry   = { diagnostics = false; metrics = false; };
      auto_update = false;
      features    = { copilot = false; };

      languages = {
        Rust    = { tab_size = 4; format_on_save = "off"; };
        Nix     = { tab_size = 2; language_servers = [ "nixd" ]; };
        Java    = { tab_size = 4; };
        Haskell = { tab_size = 2; };
        Ruby    = { tab_size = 2; language_servers = [ "solargraph" ]; };
        TOML    = { tab_size = 2; };
      };

      lsp.rust-analyzer.initialization_options = {
        check  = { command = "clippy"; };
        cargo  = { features = "all"; };
        inlayHints = {
          maxLength      = 25;
          parameterHints = { enable = true; };
          typeHints      = { enable = true; };
        };
      };
    };

    userKeymaps = [{
      context  = "Editor";
      bindings = { "ctrl-shift-k" = "editor::DeleteLine"; };
    }];
  };
}