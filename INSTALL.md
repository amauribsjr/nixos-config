# My NixOS Installation — (atm focused for my own Dell Inspiron 3501 hardware)

---

## 1. After booting in

```sh
loadkeys br-abnt2
```
*(if ABNT2 laptop keyboard)*
---

## 3. Network

First, run and connect to your WiFi network:
```sh
nmtui
```

Then test your connection:
```sh
ping -c 3 1.1.1.1
```

---

## 4. Disk Partitioning

Identify your disk first:

```sh
lsblk
```

If it's an NVME SSD, usually it'll be `nvme0n1`. But check it first!

### 4.1 Delete the partitioned tabel

```sh
parted /dev/nvme0n1 -- mklabel gpt
```

### 4.2 Create new partitions

```sh
# ESP (boot EFI) — 512 MiB
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on

# Root — rest of the whole disk
parted /dev/nvme0n1 -- mkpart primary ext4 512MiB 100%
```

Check it:

```sh
lsblk /dev/nvme0n1
```

Should be something like this:
```
nvme0n1
├─nvme0n1p1   512M
└─nvme0n1p2   The rest amount of your disk size
```

### 4.3 Format

```sh
# ESP
mkfs.fat -F 32 -n NIXOS_BOOT /dev/nvme0n1p1

# Root
mkfs.ext4 -L NIXOS_ROOT /dev/nvme0n1p2
```

---

## 5. Mount

```sh
mount /dev/disk/by-label/NIXOS_ROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot
```

Check:

```sh
lsblk -f /dev/nvme0n1
```

Should be shown mounted in `/mnt` and `/mnt/boot`.

---

## 6. Install git and clone the repository config

```sh
nix-env -iA nixos.git
```

Clone directly into `/mnt/etc/nixos`:

```sh
git clone https://github.com/amauribsjr/nixos-config /mnt/etc/nixos
```

> **Attention:** No needed, but it's better to configure SSH already.

Check structure:

```sh
ls /mnt/etc/nixos
```

Should be `flake.nix`, `system/`, `home/`, etc.

---

## 7. Generate and integrate hardware config

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

This command will only show the hardware config, nothing else will be done.

Compare `boot.initrd.availableKernelModules` generated with the one withing `system/hardware.nix`. Usually they're the same on laptops like my Inspiron 3501, but if there's any difference, update `system/hardware.nix` with the correct modules:

```sh
nano /mnt/etc/nixos/system/hardware.nix
```

`fileSystems` **doesn't need to be** in `hardware.nix` cause it's already declared `by-label` within `system/hardware.nix`, which is more portable.

---

## 8. Install

```sh
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

`--no-root-passwd` only if there's no need for root password, but we'll set one for user (koppi).

This step may take a little long. At first, niri-flake will compile localy. Expected something between 10 and 20 minutes.

---

## 9. Set user password

Before reboot, set a password for `koppi`:

```sh
nixos-enter --root /mnt -c 'passwd koppi'
```

---

## 10. Reboot

```sh
umount -R /mnt
reboot
```

Remove your flashdrive when the screen turns off.

---

## 11. First boot

SDDM will show up. Login with `koppi`.

Then niri show up as well, as so waybar, but probably **without wallpaper** as the folder still doesn't exists. Create and put an image inside to set a brand new wallpaper:

```sh
mkdir -p ~/Pictures/Wallpapers
```

Wallpaper will load at next login (awww-daemon tries at booting then give up if there's nothing)

---

## 12. Post installation tips

### Bluetooth (manually turn on)

```sh
sudo bluetoothctl power on
bluetoothctl scan on
```

If you want it to turn on during boot, change within `system/power.nix`:

```nix
hardware.bluetooth.powerOnBoot = true;
```

### Update your system

```sh
cd ~/nixos-config
nix flake update
nixos rebuild
```

### Change wallpaper without logout

```sh
awww img ~/Pictures/Wallpapers/image-you-want.png
```

### Clean older gens

```sh
sudo nix-collect-garbage -d
sudo nixos-rebuild switch --flake ~/nixos-config#nixos  # clean rebuild
```

---

## Fast daily commands

`nixos rebuild`
`nix flake update` (update all inputs)
`awww img ~/arquivo.jpg`
`sudo bluetoothctl power on`
`niri msg action quit` (reset niri session)
`sudo nix-collect-garbage -d`
