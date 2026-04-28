# My NixOS Installation

> Focused for my own **Dell Inspiron 3501** hardware.

---

## 1. After booting in

```sh
loadkeys br-abnt2
```

> Only needed if using an ABNT2 laptop keyboard.

---

## 2. Network

First, connect to your WiFi network:

```sh
nmtui
```

Then test your connection:

```sh
ping -c 3 1.1.1.1
```

---

## 3. Disk Partitioning

Identify your disk first:

```sh
lsblk
```

If it's an NVMe SSD, it'll usually be `nvme0n1` — but check first.

### 3.1 Delete the partition table

```sh
parted /dev/nvme0n1 -- mklabel gpt
```

### 3.2 Create new partitions

```sh
# ESP (boot EFI) — 512 MiB
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on

# Root — rest of the disk
parted /dev/nvme0n1 -- mkpart primary ext4 512MiB 100%
```

Check it:

```sh
lsblk /dev/nvme0n1
```

Expected output:

```
nvme0n1
├─nvme0n1p1   512M
└─nvme0n1p2   <remaining disk size>
```

### 3.3 Format

```sh
# ESP
mkfs.fat -F 32 -n NIXOS_BOOT /dev/nvme0n1p1

# Root
mkfs.ext4 -L NIXOS_ROOT /dev/nvme0n1p2
```

---

## 4. Mount

```sh
mount /dev/disk/by-label/NIXOS_ROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot
```

Check:

```sh
lsblk -f /dev/nvme0n1
```

Both partitions should be shown mounted at `/mnt` and `/mnt/boot`.

---

## 5. Install git and clone the config

```sh
nix-env -iA nixos.git
```

Clone directly into `/mnt/etc/nixos`:

```sh
git clone https://github.com/amauribsjr/nixos-config /mnt/etc/nixos
```

> **Note:** Not required, but it's recommended to configure SSH beforehand.

Check structure:

```sh
ls /mnt/etc/nixos
```

Should show `flake.nix`, `system/`, `home/`, `lib/`, etc.

---

## 6. Generate and integrate hardware config

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

This command only prints the hardware config — nothing is written.

Compare the `boot.initrd.availableKernelModules` output with the ones in `system/hardware/hardware.nix`. Usually they match on laptops like the Inspiron 3501, but update if needed:

```sh
nano /mnt/etc/nixos/system/hardware/hardware.nix
```

> `fileSystems` doesn't need to be in `hardware.nix` — it's already declared by label in the config, which is more portable.

---

## 7. Install

```sh
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

> `--no-root-passwd` skips setting a root password — we'll set the user password instead.

This step may take a while. The `niri-flake` compiles locally on first install — expect **10 to 20 minutes**.

---

## 8. Set user password

Before rebooting, set a password for `koppi`:

```sh
nixos-enter --root /mnt -c 'passwd koppi'
```

---

## 9. Reboot

```sh
umount -R /mnt
reboot
```

Remove your flash drive when the screen turns off.

---

## 10. First boot

**GDM** will show up. Log in with `koppi`.

Niri and Waybar will start automatically. The wallpaper will likely be missing since the folder doesn't exist yet. Create it and place an image inside:

```sh
mkdir -p ~/Pictures/Wallpapers
```

> Name the image `wallpaper.png`. The wallpaper will load on next login — the `awww` daemon tries on boot and gives up gracefully if nothing is found.

---

## 11. Post-installation tips

### Bluetooth (off by default)

```sh
sudo bluetoothctl power on
bluetoothctl scan on
```

To enable on boot, change in `system/hardware/power.nix`:

```nix
hardware.bluetooth.powerOnBoot = true;
```

### Update the system

```sh
cd ~/nixos-config
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

Or using the shell alias:

```sh
nixos update
```

### Change wallpaper without logging out

```sh
awww img ~/Pictures/Wallpapers/wallpaper.png
```

### Clean old generations (keep last 3)

```sh
nixos clean
```

Or manually:

```sh
sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system +3
sudo nix-collect-garbage
```

---

## Fast daily commands

| Command | Description |
|---|---|
| `nixos rebuild` | Rebuild and switch to new config |
| `nixos update` | Update flake inputs and rebuild |
| `nixos clean` | Delete old generations, keep last 3 |
| `nixos cleanweek` | Delete generations older than 7 days |
| `nixos rollback` | Roll back to previous generation |
| `awww img ~/path/to/wallpaper.png` | Change wallpaper live |
| `sudo bluetoothctl power on` | Enable Bluetooth |
| `niri msg action quit` | Quit Niri session |
