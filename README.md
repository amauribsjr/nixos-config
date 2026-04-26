# 🐧 — barbosa nixOS flake (Niri)

NixOS + Home Manager + **Niri** (scrollable-tiling Wayland compositor)
para um **Dell Inspiron 3501**.

## 🖥️ Hardware alvo

| Componente   | Especificação                              |
|--------------|---------------------------------------------|
| Modelo       | Dell Inspiron 3501                          |
| CPU          | Intel Pentium Gold 7505 (Tiger Lake-U, 2c/4t) |
| iGPU         | Intel UHD Graphics G4 (48 EUs, arquitetura Xe-LP / Gen 12) |
| RAM          | 8 GB DDR4 (2x4GB)                           |
| Storage      | SSD NVMe 128 GB (Gen 3)                     |
| Display      | Integrado, 1366x768                         |
| Teclado      | ABNT2 (padrão ThinkPad/IBM)                 |

## 🧱 Stack

- **OS**: NixOS unstable
- **Compositor**: **Niri** (scrollable-tiling Wayland) via [niri-flake](https://github.com/sodiboo/niri-flake)
- **Shell**: Zsh + Starship
- **Terminal**: Alacritty
- **Tema**: Gruvbox Soft Dark (consistente em todos os componentes)
- **Bar**: Waybar
- **Launcher**: Fuzzel (recomendado oficialmente pelo niri)
- **Notificações**: Mako
- **Wallpaper**: swaybg
- **Greeter**: greetd + tuigreet

## 📁 Estrutura

```
nixos-config/
├── flake.nix                  # entry point
├── README.md
├── system/                    # tudo de "sistema"
│   ├── default.nix            # importa todos os submódulos
│   ├── hardware.nix           # disco, kernel modules, microcode
│   ├── boot.nix               # bootloader + kernel + sysctl
│   ├── locale.nix             # tz, locales, keymap, console
│   ├── networking.nix         # NetworkManager, hostname, firewall
│   ├── audio.nix              # pipewire
│   ├── graphics.nix           # iGPU Intel
│   ├── power.nix              # TLP, thermald, fwupd, upower, fstrim, zram
│   ├── desktop.nix            # niri systemwide, greetd, portals, fonts
│   ├── flatpak.nix            # flatpak + flathub
│   ├── virtualisation.nix     # docker
│   ├── nix.nix                # settings, gc, optimise
│   ├── packages.nix           # systemPackages + thunar/gvfs
│   └── users.nix              # users, shell
└── home/
    ├── default.nix            # entry point HM + swayidle
    ├── packages.nix           # ferramentas user-level
    ├── theme.nix              # cursor, GTK
    ├── niri.nix               # Niri (binds, layout, gestos, etc.)
    ├── waybar.nix             # bar
    ├── wallpaper.png
    ├── shell/
    │   ├── zsh.nix
    │   └── starship.nix
    ├── terminal/
    │   └── alacritty.nix
    └── apps/
        ├── fastfetch.nix
        └── fuzzel.nix         # launcher
```

---

## ⌨️ Atalhos do Niri (Mod = Super)

### Apps
| Atalho           | Ação                       |
|------------------|----------------------------|
| `Super+Enter`    | Terminal (Alacritty)       |
| `Super+D`        | Launcher (Fuzzel)          |
| `Super+B`        | Browser (Chrome)           |
| `Super+V`        | Vesktop                    |
| `Super+E`        | Editor (Zed)               |
| `Super+T`        | File manager (Thunar)      |

### Window management — **maximização e produtividade**
| Atalho              | Ação                       |
|---------------------|----------------------------|
| `Super+Q`           | Fechar janela              |
| `Super+F`           | **Fullscreen toggle**      |
| `Super+M`           | **Maximize column**        |
| `Super+Ctrl+F`      | **Expandir coluna pro espaço livre** (killer) |
| `Super+Shift+F`     | Floating toggle            |
| `Super+Shift+C`     | Centralizar coluna         |
| `Super+R`           | **Cycle preset width** (1/3, 1/2, 2/3) |
| `Super+Shift+R`     | Cycle preset height        |
| `Super+W`           | Toggle tabbed display (abas) |
| `Super+-` / `Super+=` | Resize ±10% width        |
| `Super+Shift+-` / `=` | Resize ±10% height       |

### Focus (Vim + setas)
| Atalho                  | Ação                  |
|-------------------------|-----------------------|
| `Super+H` / `Left`      | Coluna esquerda       |
| `Super+L` / `Right`     | Coluna direita        |
| `Super+K` / `Up`        | Janela acima / workspace acima |
| `Super+J` / `Down`      | Janela abaixo / workspace abaixo |

### Mover janelas (mesmas teclas + Shift)
| Atalho                       | Ação                  |
|------------------------------|-----------------------|
| `Super+Shift+H/J/K/L`        | Mover janela/coluna   |
| `Super+[` / `Super+]`        | Consumir/expelir janela na coluna |

### Workspaces
| Atalho                  | Ação                  |
|-------------------------|-----------------------|
| `Super+1..9`            | Ir para workspace     |
| `Super+Shift+1..9`      | Mover coluna pro WS   |
| `Super+O`               | **Overview**          |
| `Super+Shift+/`         | Hotkey overlay (cheat sheet) |

### Screenshots
| Atalho        | Ação                    |
|---------------|-------------------------|
| `Print`       | Interativo (área)       |
| `Ctrl+Print`  | Tela inteira            |
| `Alt+Print`   | Janela ativa            |

### Sistema
| Atalho             | Ação                   |
|--------------------|------------------------|
| `Super+Alt+L`      | Lock screen            |
| `Super+Shift+E`    | Sair (volta pro greeter) |
| `Super+Shift+P`    | Desligar monitores     |
| `Fn+brilho`        | Brightness ±5%         |
| `Fn+volume`        | Volume ±5%             |
| `Fn+mute`          | Mute toggle            |

---

## 👆 Gestos do touchpad (built-in do niri, nada a configurar)

| Gesto                       | Ação                   |
|-----------------------------|------------------------|
| **3 dedos vertical**        | Trocar workspace       |
| **3 dedos horizontal**      | Scroll horizontal pelas colunas (a feature killer do niri) |
| **4 dedos vertical**        | Toggle overview        |
| **Mouse no canto sup. esq.** | Hot corner → overview |
| **Tap 1 dedo**              | Click esquerdo         |
| **Tap 2 dedos**             | Click direito          |
| **Tap 3 dedos**             | Click meio             |

---

## 🚀 Instalação

Veja o `INSTALL.md` (já entregue separadamente) — o procedimento continua o
mesmo do passo a passo anterior. Únicas diferenças:

1. No primeiro `nixos-rebuild`, o build do niri vai puxar do
   `niri.cachix.org` (cache binário oficial do niri-flake) — não compila do
   zero. **Importante**: o niri-flake **adiciona o cache automaticamente**
   no primeiro build, mas **só na segunda execução** ele já usa. Por isso,
   `nixos-rebuild` precisa ser rodado duas vezes na primeira vez:
   - 1ª vez: build COM compilação do niri (~5-10min no Pentium Gold)
   - 2ª vez em diante: usa cache binário (segundos)

2. **Após instalar**, rode `niri msg outputs` pra confirmar o nome do
   display embarcado. Se for diferente de `eDP-1`, ajuste em
   `home/niri.nix` → `outputs`.

---

## 🎨 Tema

Paleta **Gruvbox Soft Dark** consistente em:
- `home/niri.nix` (focus-ring, background)
- `home/waybar.nix` (CSS)
- `home/terminal/alacritty.nix`
- `home/apps/fuzzel.nix`
- `home/shell/starship.nix`

Pra trocar tema, edite essas 5 referências.

---

## 🔋 Decisões de arquitetura

- **niri-flake em vez de `pkgs.niri`**: cache binário (`niri.cachix.org`)
  evita compilar niri toda hora no Pentium Gold, e a versão `niri-stable`
  está mais à frente que nixpkgs.
- **`pkgs.linuxPackages` (stable) em vez de `_latest`**: Tiger Lake é
  100% suportado faz tempo; bleeding edge não traz benefício e aumenta
  risco de regressão.
- **`max-jobs=2`, `cores=2`**: 2 núcleos físicos × 4 threads não comportam
  Nix compilando 4 derivações em paralelo sem swappar.
- **Sem swap em disco, só zram**: zram comprime em RAM com zstd (2.7×),
  economiza SSD e é mais rápido que swap em NVMe.
- **`enable32Bit = false`**: sem Wine/Steam = ~2GB a menos no store.
- **CPU governor `powersave` AC e BAT**: no `intel_pstate active`, o
  firmware ainda usa turbo dinamicamente. Não é "lento" — é eficiente.
- **`vm.swappiness = 180`**: alto de propósito. Com zram, "trocar pra swap"
  custa microssegundos.
- **Hyprland → Niri**: scrollable-tiling reduz a fricção mental de "onde
  abro essa janela". O modelo de coluna infinita combina perfeitamente
  com display 1366px (espaço é estreito, scroll horizontal é a feature).

---

## 📚 Referências

- [niri-flake docs](https://github.com/sodiboo/niri-flake/blob/main/docs.md)
- [niri wiki](https://github.com/niri-wm/niri/wiki)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [TLP Optimizing Guide](https://linrunner.de/tlp/support/optimizing.html)
