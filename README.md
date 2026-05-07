# ❄️ Amauri/koppi nixOS system

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
| Keyboard     | ABNT2, US-Intl                                   |

## Stack

- **OS**: NixOS unstable
- **Compositor**: **Niri** (scrollable-tiling Wayland) via [niri-flake](https://github.com/sodiboo/niri-flake)
- **Shell**: Zsh + Starship + direnv
- **Terminal**: Kitty
- **Theme**: Koppi
- **Bar**: Waybar
- **Launcher**: Wofi
- **Notifications**: Mako
- **Wallpaper**: awww
- **Greeter**: ReGreet
- **Editor**: Zed, Helix

## 📁 Structure

```
nixos-config/
├── flake.nix                    # Flake entrypoint: nixpkgs unstable, Home Manager, niri-flake, nixos-hardware
├── flake.lock
├── devshells.nix                # Rust, Java and C dev shells
├── README.md
├── INSTALL.md                   # Dell Inspiron 3501 install guide: btrfs + zram
├── HX-ref.md                    # Helix cheatsheet
├── direnv-ref.md                # direnv cheatsheet
├── .gitignore
├── wallpapers/                  # Wallpaper assets copied into ~/Pictures/Wallpapers
│   ├── ALLqk82.png
│   ├── classroom.jpg
│   ├── coding-3.png
│   ├── gruvbox-rainbow-nix.png
│   ├── nix.png
│   ├── tux.png
│   ├── wallpaper.png
│   └── wallpaper5.png
├── lib/
│   ├── colors.nix               # Koppi color palette
│   └── fonts.nix                # Font names and sizes
├── home/
│   ├── default.nix              # Home Manager root
│   ├── packages.nix             # User packages
│   ├── shell.nix                # Zsh, aliases, Starship, zoxide, fzf, direnv/nix-direnv
│   ├── theme.nix                # GTK theme, cursor theme, dark preference
│   ├── apps/
│   │   ├── helix.nix
│   │   ├── helix-theme.nix      # Koppi theme
│   │   ├── kitty.nix
│   │   ├── wofi.nix
│   │   └── zed-theme.nix        # Koppi theme
│   ├── cli/
│   │   ├── fastfetch.nix
│   │   └── git.nix
│   ├── desktop/
│   │   ├── niri.nix
│   │   └── waybar.nix
│   └── services/
│       ├── awww.nix             # Wallpaper daemon/service
│       └── gtklock.nix
└── system/
    ├── default.nix              # NixOS root
    ├── desktop.nix              # Niri system enablement, portals, udev rules, fonts, PipeWire, GVFS
    ├── greeter.nix              # ReGreet/greetd
    ├── core/
    │   ├── default.nix          # Core system imports + systemd-oomd
    │   ├── databases.nix
    │   ├── locale.nix           # Timezone, locales and BR/US keyboard layouts
    │   ├── networking.nix
    │   ├── nix-ld.nix           # nix-ld runtime libraries for foreign binaries
    │   ├── nix.nix
    │   ├── packages.nix         # System packages
    │   ├── users.nix
    │   └── virtualisation.nix   # Docker
    └── hardware/
        ├── default.nix          # Hardware module imports
        ├── boot.nix             # systemd-boot, Plymouth, latest kernel, boot params, sysctl tuning
        ├── graphics.nix         # Intel graphics, VA-API, Wayland/Ozone session variables
        ├── hardware.nix         # Btrfs subvolumes, filesystems, swapfile, autoscrub, Intel microcode
        └── power.nix            # zram, TLP, thermald, fwupd, upower, Bluetooth/Blueman
```

---

## ⌨️ Niri Shortcuts (Mod = Super)

### Apps
| Shortcut         | Action                  |
|------------------|-------------------------|
| `Super+Enter`    | Terminal (Kitty)        |
| `Super+D`        | Launcher (Wofi)         |
| `Super+B`        | Browser (Chrome)        |
| `Super+V`        | Vesktop                 |
| `Super+E`        | GUI Editor (Zed)        |
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

**Koppi** *(my own custom theme/color palette)* — defined in `lib/colors.nix` and propagated via `specialArgs` to all modules.

---

## References

- [niri-flake docs](https://github.com/sodiboo/niri-flake/blob/main/docs.md)
- [niri wiki](https://github.com/niri-wm/niri/wiki)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [TLP Optimizing Guide](https://linrunner.de/tlp/support/optimizing.html)
