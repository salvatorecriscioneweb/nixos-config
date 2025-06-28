{
  age.identityPaths = [
    "/persist/etc/ssh/id_ed25519"
    # "/persist/home/ssalva/.ssh/id_ed25519_sk"
  ];
  age.secrets.user_pass.file = ../../secrets/user_pass.age;
}
