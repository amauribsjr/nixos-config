# 🐧 — Amauri (koppi) nixOS flake (Niri)

NixOS + Flake with Home Manager + **Niri** (scrollable-tiling Wayland compositor)
for my **Dell Inspiron 3501**.

## 🖥️ Hardware information

| Specs        | Hardware                                    |
|--------------|---------------------------------------------|
| Model        | Dell Inspiron 3501                          |
| CPU          | Intel Pentium Gold 7505 (Tiger Lake-U, 2c/4t) |
| iGPU         | Intel UHD Graphics for 11th Gen Intel Processors |
| RAM          | 8 GB DDR4 (2x4GB)                           |
| Storage      | SSD NVMe 128 GB (Gen 3)                     |
| Display      | Integrated, 1366x768                        |
| Keyboard     | ABNT2 (ThinkPad/IBM)                        |

## 🧱 Stack

- **OS**: NixOS unstable
- **Compositor**: **Niri** (scrollable-tiling Wayland) via [niri-flake](https://github.com/sodiboo/niri-flake)
- **Shell**: Zsh + Starship
- **Terminal**: Alacritty
- **Theme**: Gruvbox Dark Soft
- **Bar**: Waybar
- **Launcher**: wofi
- **Notifications**: Mako
- **Wallpaper**: awww
- **Greeter**: SDDM

## 📁 Structure

```
nixos-config/
├── flake.nix
├── flake.lock
├── lib/
│   ├── colors.nix
│   └── fonts.nix
├── home/
│   ├── default.nix
│   ├── packages.nix
│   ├── theme.nix
│   ├── apps/
│   │   ├── fastfetch.nix
│   │   ├── awww.nix
│   │   └── wofi.nix
│   ├── desktop/
│   │   ├── niri.nix
│   │   └── waybar.nix
│   ├── shell/
│   │   ├── starship.nix
│   │   └── zsh.nix
│   └── terminal/
│       └── alacritty.nix
└── system/
    ├── default.nix
    ├── core/
    │   ├── default.nix
    │   ├── databases.nix
    │   ├── locale.nix
    │   ├── networking.nix
    │   ├── nix-ld.nix
    │   ├── nix.nix
    │   ├── packages.nix
    │   ├── users.nix
    │   └── virtualisation.nix
    ├── desktop/
    │   ├── default.nix
    │   ├── audio.nix
    │   ├── desktop.nix
    │   └── flatpak.nix
    └── hardware/
        ├── default.nix
        ├── boot.nix
        ├── graphics.nix
        ├── hardware.nix
        └── power.nix
```

---

## ⌨️ Niri Shortcuts (Mod = Super)

### Apps
| Shortcut         | Action                     |
|------------------|----------------------------|
| `Super+Enter`    | Terminal (Alacritty)       |
| `Super+D`        | Launcher (Fuzzel)          |
| `Super+B`        | Browser (Chrome)           |
| `Super+V`        | Vesktop                    |
| `Super+E`        | Editor (Zed)               |
| `Super+T`        | File manager (Nautilus)    |

### Window management — **enhanced productivity**
| Shortcut            | Action                     |
|---------------------|----------------------------|
| `Super+Q`           | Close Windows              |
| `Super+F`           | **Fullscreen toggle**      |
| `Super+M`           | **Maximize column**        |
| `Super+Ctrl+F`      | **Expand column to free space** |
| `Super+Shift+F`     | Floating toggle            |
| `Super+Shift+C`     | Center column              |
| `Super+R`           | **Cycle preset width** (1/3, 1/2, 2/3) |
| `Super+Shift+R`     | Cycle preset height        |
| `Super+W`           | Toggle tabbed display (abas) |
| `Super+-` / `Super+=` | Resize ±10% width        |
| `Super+Shift+-` / `=` | Resize ±10% height       |

### Workspaces
| Shortcut                | Action                |
|-------------------------|-----------------------|
| `Super+1..9`            | Change workspace      |
| `Super+Shift+1..9`      | Change workspace column |
| `Super+O`               | **Overview**          |

### Screenshots
| Shortcut      | Action                  |
|---------------|-------------------------|
| `Print`       | Area                    |
| `Ctrl+Print`  | Screen                  |

### System
| Shortcut           | Action                 |
|--------------------|------------------------|
| `Super+Alt+L`      | Lock screen            |
| `Super+Shift+E`    | Quit (back to SDDM)    |
| `Super+Shift+P`    | Turn monitor off       |
| `Fn+brightness`    | Brightness ±5%         |
| `Fn+volume`        | Volume ±5%             |
| `Fn+mute`          | Mute toggle            |

---

## Touchpad gestures (niri built-in)

| Gesture                     | Action                 |
|-----------------------------|------------------------|
| **3 fingers (vertical)**    | Change workspace       |
| **3 fingers (horizontal)**  | Horizontal scroll      |
| **4 fingers (vertical)**    | Toggle overview        |
| **1 finger tap**            | Left click             |
| **2 fingers tap**           | Right click            |
| **3 fingers tap**           | Middle (scroll) click  |

---

## Installation

Check [INSTALL.md](./INSTALL.md)

---

## 🎨 Theme

**Gruvbox Dark Soft**
- `home/niri.nix` (focus-ring, background)
- `home/waybar.nix` (CSS)
- `home/terminal/alacritty.nix`
- `home/apps/fuzzel.nix`
- `home/shell/starship.nix`

---

## References

- [niri-flake docs](https://github.com/sodiboo/niri-flake/blob/main/docs.md)
- [niri wiki](https://github.com/niri-wm/niri/wiki)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [TLP Optimizing Guide](https://linrunner.de/tlp/support/optimizing.html)
