{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Salvatore Criscione";
    # Deter potential scammers
    userEmail = "not.salvatore" + "@" + "gmail" + "." + "com";

    extraConfig = {
      github.user = "salvatorecriscioneweb";
      color.ui = true;
      init.defaultBranch = "main";
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
    # signing = {
    #   format = "openpgp";
    #   signByDefault = true;
    # };

    ignores = [
      # system residue
      ".cache/"
      ".DS_Store"
      ".Trashes"
      ".Trash-*"
      "*.bak"
      "*.swp"
      "*.swo"
      "*.elc"
      ".~lock*"

      # build residue
      "tmp/"
      "target/"
      "result"
      "result-*"
      "*.exe"
      "*.exe~"
      "*.dll"
      "*.so"
      "*.dylib"

      # dependencies
      ".direnv/"
      "node_modules"
      "vendor"
    ];
  };
}
