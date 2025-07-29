{ config, ... }:
{
  users.mutableUsers = false;

  users.users.ssalva = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "docker"
      "libvirtd"
      "networkmanager"
      "network"
      "audio"
      "kvm"
      "adbusers"
    ];
    createHome = true;
    description = "Salvatore Criscione";
    group = "users";
    home = "/home/ssalva";
    hashedPasswordFile = config.age.secrets.user_pass.path;
  };
}
