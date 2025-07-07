{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = ../../assets/fastfetch.png;
        padding = {
          right = 2;
          left = 2;
        };
        width = 30;
        type = "sixel";
      };
      display = {
        color = "blue";
      };
      modules = [
        "colors"
        "break"
        "os"
        "kernel"
        "shell"
        "terminal"
        "memory"
      ];
    };
  };
}
