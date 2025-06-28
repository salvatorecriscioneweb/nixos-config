{
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      ".git/"
      "*.bak"
      "deps"
      "node_modules"
      "results"
    ];
  };
}
