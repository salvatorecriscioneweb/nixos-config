{
  systemd.user.services = {
    emacs = {
      Service = {
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        PrivateTmp = true;
        ProtectSystem = true;
      };
    };
  };
}
