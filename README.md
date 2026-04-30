# 🐧 — Amauri (koppi) nixOS flake (Niri)

NixOS + Flake with Home Manager + **Niri** (scrollable-tiling Wayland compositor)
for my **Dell Inspiron 3501**.

## 🖥️ Hardware information

| Specs        | Hardware                                         |
|--------------|--------------------------------------------------|
| Model        | Dell Inspiron 3501                               |
| CPU          | Intel Pentium Gold 7505 (Tiger Lake-U, 2c/4t)    |
| iGPU         | Intel UHD Graphics for 11th Gen Intel Processors |
| RAM          | 8 GB DDR4 (2x4GB)                                |
| Storage      | SSD NVMe 128 GB (Gen 3)                          |
| Display      | Integrated, 1366x768                             |
| Keyboard     | ABNT2                                            |

## Stack

- **OS**: NixOS unstable
- **Compositor**: **Niri** (scrollable-tiling Wayland) via [niri-flake](https://github.com/sodiboo/niri-flake)
- **Shell**: Zsh + Starship + direnv
- **Terminal**: Alacritty
- **Theme**: Gruvbox Dark Soft
- **Bar**: Waybar
- **Launcher**: Wofi
- **Notifications**: Mako
- **Wallpaper**: awww
- **Greeter**: GDM
- **Editor**: Zed

## 📁 Structure

```
nixos-config/
├── flake.nix
├── flake.lock
├── devshells.nix               # Rust, Java, C dev shells
├── lib/
│   ├── colors.nix              # Gruvbox Dark Hard palette
│   └── fonts.nix               # JetBrainsMono Nerd Font
├── home/
│   ├── apps/
│   │   ├── alacritty.nix
│   │   └── wofi.nix
│   ├── cli/
│   │   └── fastfetch.nix
│   ├── desktop/
│   │   ├── niri.nix
│   │   └── waybar.nix
│   ├── services/
│   │   └── awww.nix
│   ├── default.nix
│   ├── packages.nix
│   ├── shell.nix               # Zsh + Starship + direnv
│   └── theme.nix
└── system/
    ├── default.nix
    ├── desktop.nix             # Niri + GDM + PipeWire + Flatpak + fonts
    ├── core/
    │   ├── default.nix
    │   ├── databases.nix       # MySQL
    │   ├── locale.nix          # pt_BR + en_US + ko_KR
    │   ├── networking.nix
    │   ├── nix-ld.nix
    │   ├── nix.nix
    │   ├── packages.nix
    │   ├── users.nix
    │   └── virtualisation.nix  # Docker
    └── hardware/
        ├── default.nix
        ├── boot.nix            # systemd-boot + zram sysctl tuning
        ├── graphics.nix        # Intel iHD + Wayland env vars
        ├── hardware.nix        # kernel modules + filesystems
        └── power.nix           # TLP + thermald + upower + Bluetooth
```

---

## ⌨️ Niri Shortcuts (Mod = Super)

### Apps
| Shortcut         | Action                  |
|------------------|-------------------------|
| `Super+Enter`    | Terminal (Alacritty)    |
| `Super+D`        | Launcher (Wofi)         |
| `Super+B`        | Browser (Chrome)        |
| `Super+V`        | Vesktop                 |
| `Super+E`        | Editor (Zed)            |
| `Super+T`        | File manager (Nautilus) |

### Window management
| Shortcut               | Action                             |
|------------------------|------------------------------------|
| `Super+Q`              | Close window                       |
| `Super+F`              | Fullscreen toggle                  |
| `Super+M`              | Maximize column                    |
| `Super+Ctrl+F`         | Expand column to free space        |
| `Super+Shift+F`        | Floating toggle                    |
| `Super+Shift+C`        | Center column                      |
| `Super+R`              | Cycle preset width (1/3, 1/2, 2/3) |
| `Super+Shift+R`        | Cycle preset height                |
| `Super+W`              | Toggle tabbed display              |
| `Super+-` / `Super+=`  | Resize ±10% width                  |
| `Super+Shift+-` / `=`  | Resize ±10% height                 |
| `Super+[` / `Super+]`  | Consume/expel window left/right    |

### Navigation
| Shortcut              | Action                    |
|-----------------------|---------------------------|
| `Super+H/J/K/L`       | Focus column/window (vim) |
| `Super+Arrow`         | Focus column/window       |
| `Super+Shift+H/J/K/L` | Move column/window (vim)  |
| `Super+Shift+Arrow`   | Move column/window        |
| `Super+WheelUp/Down`  | Focus column left/right   |

### Workspaces
| Shortcut            | Action                   |
|---------------------|--------------------------|
| `Super+1..9`        | Focus workspace          |
| `Super+Shift+1..9`  | Move column to workspace |
| `Super+O`           | Overview                 |

### Screenshots
| Shortcut      | Action      |
|---------------|-------------|
| `Print`       | Area        |
| `Ctrl+Print`  | Full screen |
| `Alt+Print`   | Window      |

### System
| Shortcut        | Action           |
|-----------------|------------------|
| `Super+Alt+L`   | Lock screen      |
| `Super+Shift+E` | Quit session     |
| `Super+Shift+P` | Turn monitor off |
| `Fn+Brightness` | Brightness ±5%   |
| `Fn+Volume`     | Volume ±5%       |
| `Fn+Mute`       | Mute toggle      |

---

## Touchpad gestures (niri built-in)

| Gesture                | Action           |
|------------------------|------------------|
| 3 fingers vertical     | Change workspace |
| 3 fingers horizontal   | Scroll columns   |
| 4 fingers vertical     | Toggle overview  |
| 1 finger tap           | Left click       |
| 2 fingers tap          | Right click      |
| 3 fingers tap          | Middle click     |

---

## Daily commands

| Command     | Description                          |
|-------------|--------------------------------------|
| `rebuild`   | Rebuild and switch to new config     |
| `update`    | Update flake inputs and rebuild      |
| `fastclean` | Delete old generations, keep last 3  |
| `clean`     | Delete generations older than 3 days |
| `rollback`  | Roll back to previous generation     |

---

## Theme

**Gruvbox Dark Hard** — defined in `lib/colors.nix` and propagated via `specialArgs` to all modules.

---

## References

- [niri-flake docs](https://github.com/sodiboo/niri-flake/blob/main/docs.md)
- [niri wiki](https://github.com/niri-wm/niri/wiki)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [TLP Optimizing Guide](https://linrunner.de/tlp/support/optimizing.html)
