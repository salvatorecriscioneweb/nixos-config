{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "ssalva" ];

  virtualisation = {
    libvirtd = {
      enable = true;
      extraConfig = ''
        firewall_backend=iptables
      '';
    };

    spiceUSBRedirection.enable = true;
  };

  environment = {
    systemPackages = [ pkgs.qemu ];
  };
}
