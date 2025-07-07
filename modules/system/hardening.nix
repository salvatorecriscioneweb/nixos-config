{ lib, ... }:
let
  l = lib // builtins;
in
{
  # Rip out everything by default
  environment.defaultPackages = l.mkForce [ ];

  # These are taken by nix-mineral
  boot = {
    kernel = {
      sysctl = {
        # Disable binfmt. Breaks Roseta
        "fs.binfmt_misc.status" = l.mkDefault "0";

        # Disable io_uring. May be desired for Proxmox, but is responsible
        # for many vulnerabilities and is disabled on Android + ChromeOS.
        "kernel.io_uring_disabled" = l.mkDefault "2";

        # Disable ip forwarding to reduce attack surface. May be needed for
        # VM networking.
        "net.ipv4.ip_forward" = l.mkDefault "0";
        "net.ipv4.conf.all.forwarding" = l.mkOverride 900 "0";
        "net.ipv4.conf.default.forwarding" = l.mkDefault "0";
        "net.ipv6.conf.all.forwarding" = l.mkDefault "0";
        "net.ipv6.conf.default.forwarding" = l.mkDefault "0";

        # Disable ICMP redirects to prevent some MITM attacks
        # See https://askubuntu.com/questions/118273/what-are-icmp-redirects-and-should-they-be-blocked
        "net.ipv4.conf.all.accept_redirects" = l.mkOverride 900 "0";
        "net.ipv4.conf.default.accept_redirects" = l.mkOverride 900 "0";
        "net.ipv4.conf.all.send_redirects" = l.mkOverride 900 "0";
        "net.ipv4.conf.default.send_redirects" = l.mkOverride 900 "0";
        "net.ipv6.conf.all.accept_redirects" = l.mkOverride 900 "0";
        "net.ipv6.conf.default.accept_redirects" = l.mkOverride 900 "0";

        # restrict perf subsystem usage (activity) further
        "kernel.perf_cpu_time_max_percent" = l.mkDefault "1";
        "kernel.perf_event_max_sample_rate" = l.mkDefault "1";

        # do not allow mmap in lower addresses
        "vm.mmap_min_addr" = l.mkDefault "65536";

        # disable sending and receiving of shared media redirects
        # this setting overwrites net.ipv4.conf.all.secure_redirects
        # refer to RFC1620
        "net.ipv4.conf.default.shared_media" = l.mkDefault "0";
        "net.ipv4.conf.all.shared_media" = l.mkDefault "0";

      };
    };

    kernelParams = [
      # Requires all kernel modules to be signed. This prevents out-of-tree
      # kernel modules from working unless signed.
      "module.sig_enforce=1"
      # May break some drivers, same reason as the above. Also breaks
      # hibernation.
      "lockdown=confidentiality"
      # Disables multilib/32 bit applications to reduce attack surface.
      "ia32_emulation=0"
    ];
  };

  # TODO: Check if breaks too much stuff
  environment.memoryAllocator.provider = "graphene-hardened-light";
  services.dbus.apparmor = l.mkDefault "enabled";

  zramSwap.enable = l.mkDefault true;

  services = {
    openssh.settings.PermitRootLogin = l.mkForce "no";
    # DNS connections will fail if not using a DNS server supporting DNSSEC.
    resolved.dnssec = l.mkDefault "true";
  };

  # Don't store coredumps from systemd-coredump.
  systemd.coredump.extraConfig = ''
    Storage=none
  '';

  networking = {
    firewall = {
      allowedTCPPorts = l.mkDefault [ ];
      allowedUDPPorts = l.mkDefault [ ];
      enable = l.mkDefault true;
    };
    networkmanager = {
      ethernet.macAddress = l.mkDefault "random";
      wifi = {
        macAddress = l.mkDefault "random";
        scanRandMacAddress = l.mkDefault true;
      };
      # Enable IPv6 privacy extensions in NetworkManager.
      connectionConfig."ipv6.ip6-privacy" = l.mkDefault 2;
    };
  };

  security = {
    apparmor = {
      enable = l.mkDefault true;
      killUnconfinedConfinables = l.mkDefault true;
    };

    sudo = {
      execWheelOnly = true;
    };

    # Polkit
    polkit.enable = true;

    # RTKit
    rtkit.enable = true;

    # PAM
    pam = {
      services.swaylock = { };
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
      u2f.enable = true;
    };

  };

}
