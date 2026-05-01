# NixOS Installation — Dell Inspiron 3501 (btrfs + zswap)

> Hardware-specific guide. **Adapt disk path** if not using NVMe.
> All destructive steps require explicit verification with `lsblk` first.

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

## 3. Disk identification

```sh
lsblk
```

NVMe SSDs are usually `nvme0n1`. **Confirm before proceeding.**
This guide assumes `/dev/nvme0n1`. If yours differs, replace in every command below.

---

## 4. Partitioning

### 4.1 GPT table

```sh
parted /dev/nvme0n1 -- mklabel gpt
```

### 4.2 Three partitions

```sh
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart swap linux-swap 512MiB 8704MiB
parted /dev/nvme0n1 -- mkpart root btrfs 8704MiB 100%
```

Verify:

```sh
lsblk /dev/nvme0n1
```

Expected:

```
nvme0n1
├─nvme0n1p1   512M
├─nvme0n1p2   8G
└─nvme0n1p3   <remaining>
```

### 4.3 Format

```sh
mkfs.fat -F 32 -n NIXOS_BOOT /dev/nvme0n1p1
mkswap -L NIXOS_SWAP /dev/nvme0n1p2
mkfs.btrfs -L NIXOS_ROOT /dev/nvme0n1p3
```

---

## 5. Subvolumes

```sh
mount /dev/disk/by-label/NIXOS_ROOT /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@log
umount /mnt
```

---

## 6. Mount

```sh
DISK=/dev/disk/by-label/NIXOS_ROOT
OPT="compress=zstd:3,noatime,ssd,space_cache=v2,discard=async"

mount -o subvol=@,$OPT $DISK /mnt
mkdir -p /mnt/{home,nix,var/log,boot}
mount -o subvol=@home,$OPT $DISK /mnt/home
mount -o subvol=@nix,$OPT $DISK /mnt/nix
mount -o subvol=@log,$OPT $DISK /mnt/var/log
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot
swapon /dev/disk/by-label/NIXOS_SWAP
```

Verify:

```sh
findmnt /mnt /mnt/home /mnt/nix /mnt/var/log /mnt/boot
swapon --show
```

All five mounts and the swap should be listed.

---

## 7. Clone the config

```sh
nix-env -iA nixos.git
git clone -b btrfs-zswap https://github.com/amauribsjr/nixos-config /mnt/etc/nixos
```

---

## 8. Verify hardware modules

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

Compare `boot.initrd.availableKernelModules` with `system/hardware/hardware.nix`.
The `fileSystems` block in this repo is already declared by label — do **not** overwrite it.

If kernel modules differ, edit only that block:

```sh
nano /mnt/etc/nixos/system/hardware/hardware.nix
```

---

## 9. Install

```sh
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

First install compiles niri-flake locally — expect **10–20 minutes**.

---

## 10. Set user password

```sh
nixos-enter --root /mnt -c 'passwd koppi'
```

---

## 11. Reboot

```sh
umount -R /mnt
swapoff -a
reboot
```

Remove the flash drive when the screen turns off.

---

## 12. First boot

GDM/regreet appears. Log in as `koppi`.

Validate the install:

```sh
findmnt -t btrfs                              # @, @home, @nix, @log
cat /sys/module/zswap/parameters/enabled      # Y
cat /sys/module/zswap/parameters/compressor   # zstd
swapon --show                                 # NIXOS_SWAP partition
```

Create folders used by Niri:

```sh
mkdir -p ~/Pictures/{Wallpapers,Screenshots}
```

Place a `wallpaper.png` inside `~/Pictures/Wallpapers/`. Loads on next login.

---

## 13. Post-install

### Restore SSH key (if backed up)

```sh
cp /run/media/koppi/<DRIVE>/koppi-backup/.ssh/id_ed25519_github* ~/.ssh/
chmod 600 ~/.ssh/id_ed25519_github
chmod 644 ~/.ssh/id_ed25519_github.pub
ssh -T git@github.com
```

If no backup, the activation script generates a fresh key on first rebuild — add it to GitHub manually.

### direnv (project shells)

In any project with a `flake.nix` or `shell.nix`:

```sh
echo "use flake" > .envrc
direnv allow
```

### Merge to main

After a few days of stable use:

```sh
cd ~/nixos-config
git checkout main
git merge btrfs-zswap
git push
```