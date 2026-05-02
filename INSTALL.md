# NixOS Installation — Dell Inspiron 3501 (btrfs + zram)

> Hardware-specific guide. **Verify disk path** with `lsblk` before destructive steps.

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

NVMe SSDs are usually `nvme0n1`. **Confirm before proceeding.** This guide assumes `/dev/nvme0n1`.

---

## 4. Partitioning

Two partitions only — no swap (zram handles it):

```sh
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart root btrfs 512MiB 100%
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

Format:

```sh
mkfs.fat -F 32 -n NIXOS_BOOT /dev/nvme0n1p1
mkfs.btrfs -L NIXOS_ROOT /dev/nvme0n1p2
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
OPT="compress=zstd:1,noatime,discard=async"

mount -o subvol=@,$OPT $DISK /mnt
mkdir -p /mnt/{home,nix,var/log,boot}
mount -o subvol=@home,$OPT $DISK /mnt/home
mount -o subvol=@nix,$OPT $DISK /mnt/nix
mount -o subvol=@log,$OPT $DISK /mnt/var/log
mount /dev/disk/by-label/NIXOS_BOOT /mnt/boot
```

Verify:

```sh
findmnt /mnt /mnt/home /mnt/nix /mnt/var/log /mnt/boot
```

All five mounts should be listed.

---

## 7. Clone the config

```sh
nix-env -iA nixos.git
git clone -b btrfs-zram https://github.com/amauribsjr/nixos-config /mnt/etc/nixos
```

---

## 8. Verify hardware modules

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

Compare `boot.initrd.availableKernelModules` with `system/hardware/hardware.nix`.
The `fileSystems` block in this repo is already declared by label — do **not** overwrite it.

If kernel modules differ:

```sh
nano /mnt/etc/nixos/system/hardware/hardware.nix
```

---

## 9. Install

```sh
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
```

First install compiles flake inputs locally. With niri-flake's Cachix cache (auto-enabled by `nixosModules.niri`), most heavy builds are skipped — expect **~15–25 minutes** total instead of the previous 40+.

If you see niri being compiled from source (long Rust build), the cache is missing — abort with `Ctrl+C` and verify `niri-flake.cache.enable` is not set to `false` anywhere in the config.

---

## 10. Set user password

```sh
nixos-enter --root /mnt -c 'passwd koppi'
```

---

## 11. Reboot

```sh
umount -R /mnt
reboot
```

Remove the flash drive when the screen turns off.

---

## 12. First boot

GDM/regreet appears. Log in as `koppi`.

Validate the install:

```sh
findmnt -t btrfs                       # @, @home, @nix, @log
swapon --show                          # /dev/zram0 only
sudo btrfs property get / compression  # zstd:1
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

If no backup, the home-manager activation script generates a fresh key on first rebuild — copy the printed public key to GitHub.

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
git merge btrfs-zram
git push
```