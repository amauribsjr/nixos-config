# 🐧 - barbosa nixOS flakes

Complete system with Home Manager.

## 🖥️  System specs (Desktop)

- **OS**: NixOS (unstable)
- **WM**: Hyprland
- **GPU**: NVIDIA RTX 3060 Ti
- **Monitors**: 
  - 1: QuadHD 180Hz (2560x1440)
  - 2: FullHD 60Hz (1920x1080)
- **Shell**: ZSH + Starship
- **Terminal**: Alacritty
- **Theme**: Gruvbox Dark Soft

## 📁
```nixos-config/
├── flake.nix
├── flake.lock
├── hosts/
│   └── nixos/
│       ├── configuration.nix
│       └── hardware.nix
├── modules/
│   └── system/
│       ├── boot.nix
│       ├── nvidia.nix
│       ├── gaming.nix         #Steam+Gamemode
│       └── virtualisation.nix #Docker
└── home/
└── barbosa/
├── home.nix            # Config principal do usuário
├── wallpaper.png       # Wallpaper
├── programs/
│   ├── zsh.nix
│   ├── starship.nix
│   └── alacritty.nix
└── desktop/
├── hyprland.nix
└── waybar.nix```
### Steps
```bash
# 1. Clone repo
git clone https://github.com/amauribsjr/nixos-config.git ~/nixos-config
cd ~/nixos-config

# 2. Copy hardware-configuration
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/nixos/hardware.nix

# 3. Adjuste monitor names/IDs
# Verify: hyprctl monitors
nano home/barbosa/desktop/hyprland.nix

# 4. Add wallpaper
cp /Home/barbosa/Pictures/wallpaper.png home/barbosa/wallpaper.png

# 5. Initial build
sudo nixos-rebuild build --flake .#nixos

# 6. Apply
sudo nixos-rebuild switch --flake .#nixos

# 7. Reboot
reboot
```

## 🔧 Daily usage

### Alias
```bash
# Rebuild
nixos rebuild

# Update flakes + rebuild
nixos update

# Clean
nixos clean

# Commands
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
cd ~/nixos-config && nix flake update
sudo nix-collect-garbage -d
```

### Modifying system

1. Settings and archives `~/nixos-config`
2. Git commit: `git add . && git commit -m "desc"`
3. Rebuild: `nixos rebuild`
4. Rollback: `sudo nixos-rebuild switch --rollback`

### Update system
```bash
cd ~/nixos-config
nix flake update              # Update flake.lock
git add flake.lock
git commit -m "Update flakes"
nixos rebuild                 # Apply updates
```

## 🎨 Customization

### Color theme

Edit Gruvbox colors:
- `home/barbosa/desktop/waybar.nix` (CSS inline)
- `home/barbosa/desktop/hyprland.nix` (borders)
- `home/barbosa/programs/alacritty.nix` (terminal)
- `home/barbosa/programs/starship.nix` (prompt)

### Add Package

**System**: `hosts/nixos/configuration.nix` → `environment.systemPackages`

**User**: `home/barbosa/home.nix` → `home.packages`

### Add ap w/ Config

1. Create `home/barbosa/programs/appName.nix`
2. Import to `home/barbosa/home.nix`
3. Config `programs.appName = { ... };`

## 📦 Installed packages

### Syste,
- Core: vim, wget, git, btop
- WM: Hyprland, Waybar, Rofi
- Apps: Chrome, Vesktop, Zed, VSCode
- Gaming: Steam, Gamemode
- Dev: JDK 21, Rust, GCC

### Tools
- File Manager: Yazi, Thunar
- Screenshots: Grim, Slurp, Swappy
- Audio: Pipewire, Pavucontrol
- Utils: fzf, ripgrep, fd, zoxide

## 🐛 Troubleshooting

### Monitor trobeshoot
```bash
hyprctl monitors
# Adjust: /home/barbosa/desktop/hyprland.nix
```

### Waybar trobleshoot
```bash
systemctl --user status waybar
journalctl --user -u waybar -f
```

### Rollback
```bash
sudo nixos-rebuild switch --rollback
```

### Nvidia trobeshoot
```bash
nvidia-smi
# Verify logs: journalctl -b | grep nvidia
```

## 📚 Links

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Wiki](https://nixos.wiki/)


## 📄 Licença
MIT
