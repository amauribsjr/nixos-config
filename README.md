# 🐧 — barbosa nixOS flake (Niri)

NixOS + Home Manager + **Niri** (scrollable-tiling Wayland compositor)
for my **Dell Inspiron 3501**.

## 🖥️ Hardware information

| Specs        | Hardware                                    |
|--------------|---------------------------------------------|
| Model        | Dell Inspiron 3501                          |
| CPU          | Intel Pentium Gold 7505 (Tiger Lake-U, 2c/4t) |
| iGPU         | Intel UHD Graphics G4 (48 EUs, Xe-LP / Gen 12) |
| RAM          | 8 GB DDR4 (2x4GB)                           |
| Storage      | SSD NVMe 128 GB (Gen 3)                     |
| Display      | Integrated, 1366x768                        |
| Keyboard     | ABNT2 (ThinkPad/IBM)                        |

## 🧱 Stack

- **OS**: NixOS unstable
- **Compositor**: **Niri** (scrollable-tiling Wayland) via [niri-flake](https://github.com/sodiboo/niri-flake)
- **Shell**: Zsh + Starship
- **Terminal**: Alacritty
- **Theme**: Gruvbox Soft Dark
- **Bar**: Waybar
- **Launcher**: Fuzzel (niri default recommendation)
- **Notifications**: Mako
- **Wallpaper**: swaybg
- **Greeter**: greetd + tuigreet *(temporary)*

## 📁 Structure

```
nixos-config/
├── flake.nix                  # entry point
├── README.md
├── system/                    
│   ├── default.nix            # import all submodules
│   ├── hardware.nix           # disk, kernel modules, microcode
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
    ├── packages.nix           # user-level tools
    ├── theme.nix              # cursor, GTK
    ├── niri.nix               # Niri (binds, layout, gestures, etc.)
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

## ⌨️ Niri Shortcuts (Mod = Super)

### Apps
| Shortcut         | Action                     |
|------------------|----------------------------|
| `Super+Enter`    | Terminal (Alacritty)       |
| `Super+D`        | Launcher (Fuzzel)          |
| `Super+B`        | Browser (Chrome)           |
| `Super+V`        | Vesktop                    |
| `Super+E`        | Editor (Zed)               |
| `Super+T`        | File manager (Thunar)      |

### Window management — **enhanced productivity**
| Shortcut            | Action                     |
|---------------------|----------------------------|
| `Super+Q`           | Close Windows              |
| `Super+F`           | **Fullscreen toggle**      |
| `Super+M`           | **Maximize column**        |
| `Super+Ctrl+F`      | **Expand column to free space** (killer) |
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
| `Super+Shift+1..9`      | Change workspace column   |
| `Super+O`               | **Overview**          |
| `Super+Shift+/`         | Hotkey overlay (cheat sheet) |

### Screenshots
| Shortcut      | Action                  |
|---------------|-------------------------|
| `Print`       | Area                    |
| `Shift+Print`  | Whole screen            |

### System
| Shortcut           | Action                 |
|--------------------|------------------------|
| `Super+Alt+L`      | Lock screen            |
| `Super+Shift+E`    | Quit (back to greeter) |
| `Super+Shift+P`    | Turn monitor off       |
| `Fn+brilho`        | Brightness ±5%         |
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

Check `INSTALL.md`

---

## 🎨 Theme

**darkSEA** colors:
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
