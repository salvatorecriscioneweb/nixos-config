{ lib, pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "postgres";
      }
    ];
    ensureDatabases = [
      "kopikas_wallet_dev"
      "postgres"
    ];
    enableTCPIP = true;
    settings = {
      log_connections = true;
      max_connections = 5000;
    };
    authentication = lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
  };
}
