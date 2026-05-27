# ❄️ Amauri - koppi NixOS system

Personal NixOS flake for my **Dell Inspiron 3501**, built around Flake-parts, Home Manager, **Niri** and **Koppi**, my own custom theme.

## Hardware

| Spec     | Hardware                                         |
| -------- | ------------------------------------------------ |
| Model    | Dell Inspiron 3501                               |
| CPU      | Intel Pentium Gold 7505, Tiger Lake-U, 2c/4t     |
| GPU      | Intel UHD Graphics for 11th Gen Intel Processors |
| RAM      | 8 GB DDR4, 2x4 GB                                |
| Storage  | 128 GB NVMe SSD                                  |
| Display  | Integrated 1366x768                              |
| Keyboard | ABNT2, US-Intl                                   |

## Stack

| Area          | Tooling                                                                     |
| ------------- | --------------------------------------------------------------------------- |
| OS            | NixOS unstable                                                              |
| Flake inputs  | nixpkgs, flake-parts, Home Manager, nixos-hardware, niri-flake, koppi-theme |
| Compositor    | Niri                                                                        |
| Shell         | Zsh, Starship, zoxide, fzf                                                  |
| Terminal      | Kitty                                                                       |
| Bar           | Waybar                                                                      |
| Launcher      | Wofi                                                                        |
| Notifications | Mako                                                                        |
| Wallpaper     | awww                                                                        |
| Lock screen   | gtklock                                                                     |
| Greeter       | greetd + ReGreet                                                            |
| Editors       | Zed                                                                         |
| Dev tooling   | Java, Rust, C and Flutter, Bruno                                            |
| Databases     | MySQL, PostgreSQL and Redis for caching                                     |
| Theme         | [Koppi](https://github.com/amauribsjr/koppi-theme)                          |

## Koppi theme

- **Koppi** is my own dark theme layer for the system, now with its own repository. 
- Check it here: [Koppi Theme](https://github.com/amauribsjr/koppi-theme)

The core theme files (besides Koppi Theme) are:

| File             | Purpose                                                        |
| ---------------- | -------------------------------------------------------------- |
| `lib/fonts.nix`  | Shared font names and sizes.                                   |
| `lib/theme.nix`  | GTK theme, cursor theme, font packages and wallpaper metadata. |

These values are imported in `flake.nix` and passed to both NixOS and Home Manager modules through `specialArgs` and `extraSpecialArgs`.

## Structure

```text
nixos-config/
├── docs/
│   └── devshells.md           # devShell usage and workflow reference
├── flake.nix                  # flake-parts entrypoint, NixOS config and shared args
├── flake.lock                 # pinned flake inputs
├── README.md                  # repository overview
├── lib/
│   ├── fonts.nix              # shared font names/sizes
│   └── theme.nix              # GTK, cursor, font packages, wallpaper metadata
├── home/
│   ├── default.nix            # Home Manager root
│   ├── packages.nix           # user packages
│   ├── shell.nix              # Zsh, aliases, prompt, helpers
│   ├── theme.nix              # GTK, cursor and dark preference
│   ├── apps/
│   │   ├── kitty.nix          # terminal config
│   │   ├── office.nix         # office apps
│   │   ├── wofi.nix           # launcher config/style
│   │   └── zed-theme.nix      # Zed consumes Koppi Theme
│   ├── cli/
│   │   ├── fastfetch.nix      # system summary (minimal fastfetch)
│   │   └── git.nix            # git config
│   ├── desktop/
│   │   ├── niri.nix           # compositor, binds, rules, startup
│   │   └── waybar.nix         # bar modules and Koppi styling
│   └── services/
│       ├── awww.nix           # wallpaper daemon
│       ├── gtklock.nix        # lock screen with Koppi styling
│       └── swayidle.nix       # AC/BAT idle profiles
└── system/
    ├── default.nix            # NixOS root module
    ├── desktop.nix            # Niri, portals, fonts, audio, GVFS
    ├── greeter.nix            # greetd/ReGreet with Koppi styling
    ├── core/
    │   ├── default.nix        # core imports and systemd-oomd
    │   ├── locale.nix         # locale, timezone, keyboard
    │   ├── networking.nix     # hostname and NetworkManager
    │   ├── nix.nix            # Nix settings, GC, optimization
    │   ├── packages.nix       # system packages
    │   └── users.nix          # user, shell, groups
    ├── development/
    │   ├── default.nix        # development imports
    │   ├── nix-ld.nix         # nix-ld runtime support
    │   ├── devtools.nix       # development tools
    │   ├── mobiletools.nix    # mobile development tools (temporary)
    │   ├── databases.nix      # MySQL and PostgreSQL services
    │   ├── redis.nix          # Redis services
    │   └── virtualisation.nix # Docker    
    └── hardware/
        ├── default.nix        # hardware imports
        ├── boot.nix           # bootloader, kernel, sysctl
        ├── graphics.nix       # Intel graphics, VA-API, Wayland vars
        ├── hardware.nix       # filesystems, Btrfs, swap, firmware
        └── power.nix          # zram, TLP, thermald, fwupd, Bluetooth
```

## Main services

| Service        | Scope         | File                                              |
| -------------- | ------------- | ------------------------------------------------- |
| Niri           | System + Home | `system/desktop.nix`, `home/desktop/niri.nix`     |
| Waybar         | Home          | `home/desktop/waybar.nix`                         |
| Mako           | Home          | `home/default.nix`                                |
| awww           | Home          | `home/services/awww.nix`                          |
| gtklock        | Home/System   | `home/services/gtklock.nix`, `system/desktop.nix` |
| swayidle       | Home          | `home/services/swayidle.nix`                      |
| Office/PDF     | Home          | `home/apps/office.nix`                            |
| greetd/ReGreet | System        | `system/greeter.nix`                              |
| Docker         | System        | `system/development/virtualisation.nix`           |
| Redis          | System        | `system/development/redis.nix`                    |
| MySQL          | System        | `system/development/databases.nix`                |
| PostgreSQL     | System        | `system/development/databases.nix`                |
| TLP/zram       | System        | `system/hardware/power.nix`                       |

## Shell commands

Custom shell functions are defined in `home/shell.nix`.

| Command     | Description                                                                  |
| ----------- | ---------------------------------------------------------------------------- |
| `rebuild`   | Rebuild and switch to the current flake configuration.                       |
| `testbuild` | Test the current flake configuration.                                        |
| `update`    | Update flake inputs and test/rebuild according to the helper implementation. |
| `flakeup`   | Update `flake.lock` and commit the lockfile update.                          |
| `rollback`  | Roll back to the previous NixOS generation.                                  |
| `clean`     | Delete older than 7 days generations.                                        |
| `deepclean` | Keep only the 3 latest system generations and run garbage collection.        |
| `wall`      | Select and apply a wallpaper using `fzf` and `chafa`.                        |

### Databases

| Alias       | Description                                     |
| ----------- | ----------------------------------------------- |
| `pgstart`   | Starts PostgreSQL services (default port: 5432) |
| `pgstop`    | Stops PostgreSQL services                       |
| `mystart`   | Starts MySQL services (default port: 3308)      |
| `mystop`    | Stops MySQL services                            |
| `redistart` | Starts Redis services (default port: 6379)      |
| `redistop`  | Stops Redis services                            |

### Applications

| Shortcut      | Action              |
| ------------- | ------------------- |
| `Super+Enter` | Open Kitty          |
| `Super+D`     | Open Wofi Launcher  |
| `Super+B`     | Open Google Chrome  |
| `Super+S`     | Open Spotify        |
| `Super+V`     | Open Vesktop        |
| `Super+E`     | Open Zed            |
| `Super+T`     | Open Nautilus       |

### Window management

| Shortcut                          | Action                             |
| --------------------------------- | ---------------------------------- |
| `Super+Q`                         | Close window                       |
| `Super+F`                         | Toggle fullscreen                  |
| `Super+M`                         | Maximize column                    |
| `Super+Ctrl+F`                    | Expand column to available width   |
| `Super+Shift+F`                   | Toggle floating                    |
| `Super+Shift+C`                   | Center column                      |
| `Super+R`                         | Cycle preset column width          |
| `Super+Shift+R`                   | Cycle preset window height         |
| `Super+W`                         | Toggle tabbed column display       |
| `Super+-` / `Super+=`             | Decrease/increase column width     |
| `Super+Shift+-` / `Super+Shift+=` | Decrease/increase window height    |
| `Super+[` / `Super+]`             | Consume or expel window left/right |

### Navigation

| Shortcut              | Action                                   |
| --------------------- | ---------------------------------------- |
| `Super+H/J/K/L`       | Focus column/window using Vim-style keys |
| `Super+Arrow`         | Focus column/window using arrows         |
| `Super+Shift+H/J/K/L` | Move column/window using Vim-style keys  |
| `Super+Shift+Arrow`   | Move column/window using arrows          |
| `Super+WheelUp/Down`  | Focus column left/right                  |

### Workspaces

| Shortcut           | Action                   |
| ------------------ | ------------------------ |
| `Super+1..9`       | Focus workspace          |
| `Super+Shift+1..9` | Move column to workspace |
| `Super+O`          | Toggle overview          |

### Screenshots

| Shortcut     | Action                |
| ------------ | --------------------- |
| `Print`      | Area screenshot       |
| `Ctrl+Print` | Fullscreen screenshot |
| `Alt+Print`  | Window screenshot     |

### System

| Shortcut        | Action             |
| --------------- | ------------------ |
| `Super+Alt+L`   | Lock screen        |
| `Super+Shift+E` | Quit session       |
| `Super+Shift+P` | Turn monitors off  |
| Brightness keys | Adjust brightness  |
| Volume keys     | Adjust volume/mute |

## Touchpad gestures

| Gesture              | Action           |
| -------------------- | ---------------- |
| 3 fingers vertical   | Change workspace |
| 3 fingers horizontal | Scroll columns   |
| 4 fingers vertical   | Toggle overview  |
| 1 finger tap         | Left click       |
| 2 fingers tap        | Right click      |
| 3 fingers tap        | Middle click     |

## References

* [niri-flake docs](https://github.com/sodiboo/niri-flake/blob/main/docs.md)
* [niri wiki](https://github.com/niri-wm/niri/wiki)
* [NixOS Manual](https://nixos.org/manual/nixos/stable/)
* [Home Manager Manual](https://nix-community.github.io/home-manager/)
* [TLP Optimizing Guide](https://linrunner.de/tlp/support/optimizing.html)