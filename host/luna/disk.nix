{
  lib,
  ...
}:
let
  enc_p = "1fb8b213-3ac5-4a1b-b2b8-3a8a04078e70";
  root_p = "3d717323-aec8-41c2-a650-656e3dfd20db";
  boot_p = "E6BB-8D1E";
in
{
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "sd_mod"
      "sr_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "btrfs" ];
  };

  # boot.initrd.postDeviceCommands = lib.mkAfter ''
  #   mkdir /btrfs_tmp
  #   mount /dev/mapper/enc /btrfs_tmp

  #   if [[ -e /btrfs_tmp/home ]]; then
  #       mkdir -p /btrfs_tmp/old_homes
  #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/home)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /btrfs_tmp/home "/btrfs_tmp/old_homes/$timestamp"
  #   fi

  #   if [[ -e /btrfs_tmp/root ]]; then
  #       mkdir -p /btrfs_tmp/old_roots
  #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
  #   fi

  #   delete_subvolume_recursively() {
  #       IFS=$'\n'
  #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
  #           delete_subvolume_recursively "/btrfs_tmp/$i"
  #       done
  #       btrfs subvolume delete "$1"
  #   }

  #   for i in $(find /btrfs_tmp/old_homes/ -maxdepth 1 -mtime +5); do
  #       delete_subvolume_recursively "$i"
  #   done

  #   for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +5); do
  #       delete_subvolume_recursively "$i"
  #   done

  #   btrfs subvolume create /btrfs_tmp/root
  #   btrfs subvolume create /btrfs_tmp/home

  #   umount /btrfs_tmp
  # '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/${root_p}";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "noatime"
      "noexec"
    ];
  };

  boot.initrd.luks.devices."enc" = {
    device = "/dev/disk/by-uuid/${enc_p}";
    allowDiscards = true;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/${root_p}";
    fsType = "btrfs";
    neededForBoot = lib.mkForce true;
    options = lib.mkForce [
      "subvol=home"
      "compress=zstd"
      "noatime"
      "noexec"
      "nodev"
      "nosuid"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/${root_p}";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/${root_p}";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "subvol=persist"
      "compress=zstd"
      "noatime"
      "noexec"
      "nodev"
      "nosuid"
    ];
  };

  fileSystems."/persist/home/ssalva/.mix" = {
    device = "/persist/home/ssalva/.mix";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/persist/home/ssalva/.tmux" = {
    device = "/persist/home/ssalva/.tmux";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/persist/home/ssalva/dev" = {
    device = "/persist/home/ssalva/dev";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/persist/home/ssalva/.cache/Google" = {
    device = "/persist/home/ssalva/.cache/Google";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };
  fileSystems."/persist/home/ssalva/.skiko" = {
    device = "/persist/home/ssalva/.skiko";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/persist/home/ssalva/Android" = {
    device = "/persist/home/ssalva/Android";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/persist/home/ssalva/.config/emacs" = {
    device = "/persist/home/ssalva/.config/emacs";
    fsType = "none";
    options = [
      "defaults"
      "bind"
      "user"
      "exec"
      "nofail"
    ];
  };

  fileSystems."/tmp" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=6G"
      "mode=755"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/${root_p}";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "subvol=log"
      "compress=zstd"
      "noatime"
      "noexec"
      "nosuid"
      "nodev"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/${boot_p}";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];
}
