{
  programs.lazygit = {
    enable = true;

    settings = {
      disableStartupPopups = true;
      prompt = "enabled";
      update.method = "never";
      git.paging = {
        colorArg = "always";
      };
    };
  };
}
