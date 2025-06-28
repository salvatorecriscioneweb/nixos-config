let
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmn+FWlDUs8fUIxMGaa0/QyrUbUbl9j3HBONl7zxUFb root@luna";
in
{
  "user_pass.age".publicKeys = [ system ];
}
