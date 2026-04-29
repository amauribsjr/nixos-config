# NixOS Installation — Dell Inspiron 3501

> Hardware-specific guide for this flake. Adapt if running on different hardware.

---

## 1. Boot and keyboard

```sh
loadkeys br-abnt2
```

---

## 2. Network

```sh
nmtui
ping -c 3 1.1.1.1
```

---

## 3. Disk partitioning

Identify the disk:

```sh
lsblk
```

NVMe SSDs are usually `nvme0n1` — confirm before proceeding.

### 3.1 Create GPT partition table

```sh
parted /dev/nvme0n1 -- mklabel gpt
```

### 3.2 Partitions

```sh
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary ext4 512MiB 100%
```

Verify:

```sh
lsblk /dev/nvme0n1
```

Expected:

```
nvme0n1
├─nvme0n1p1   512M
└─nvme0n1p2   <remaining>
```

### 3.3 Format

```sh
mkfs.fat -F 32 -n NIXOS_BOOT /dev/nvme0n1p1
mkfs.ext4 -L NIXOS_ROOT /dev/nvme0n1p2
```

---

## 4. Mount

```sh
mount /dev/disk/by-label/NIXOS_ROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot
```

---

## 5. Clone the config

```sh
nix-env -iA nixos.git
git clone https://github.com/amauribsjr/nixos-config /mnt/etc/nixos
```

---

## 6. Verify hardware modules

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

Compare `boot.initrd.availableKernelModules` with `system/hardware/hardware.nix`. Edit if needed:

```sh
nano /mnt/etc/nixos/system/hardware/hardware.nix
```

The `fileSystems` block is already declared by label — no changes needed there.

---

## 7. Install

```sh
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

First install compiles niri-flake locally — expect **10–20 minutes**.

---

## 8. Set user password

```sh
nixos-enter --root /mnt -c 'passwd koppi'
```

---

## 9. Reboot

```sh
umount -R /mnt
reboot
```

Remove the flash drive when the screen turns off.

---

## 10. First boot

GDM will appear. Log in as `koppi`. Niri and Waybar start automatically.

Create the wallpaper folder:

```sh
mkdir -p ~/Pictures/Wallpapers
```

Place a `wallpaper.png` inside. It loads on next login.

Create the screenshots folder (used by Niri):

```sh
mkdir -p ~/Pictures/Screenshots
```

---

## 11. SSH key for GitHub

Generate the key (leave passphrase empty if you don't want one):

```sh
ssh-keygen -t ed25519 -C "you-email" -f ~/.ssh/id_ed25519_github
```

Create the SSH config so the client knows which key to use:

```sh
cat > ~/.ssh/config << 'EOF'
Host github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
EOF
```

Copy the public key:

```sh
cat ~/.ssh/id_ed25519_github.pub | wl-copy
```

Add it at **https://github.com/settings/keys** → New SSH key → paste → save.

Test:

```sh
ssh -T git@github.com
# Hi user! You've successfully authenticated...
```

---

## 12. Post-install

### Bluetooth (off by default)

```sh
sudo bluetoothctl power on
bluetoothctl scan on
```

To enable on boot, set in `system/hardware/power.nix`:

```nix
hardware.bluetooth.powerOnBoot = true;
```

### direnv (project shells)

In any project with a `flake.nix` or `shell.nix`:

```sh
echo "use flake" > .envrc
direnv allow
```

The shell activates automatically when you `cd` into the directory.
