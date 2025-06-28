{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 2;
        };
      };
      display = {
        color = "blue";
      };
      modules = [
        "colors"
        "break"
        "os"
        "shell"
        "terminal"
      ];
    };
  };
}
