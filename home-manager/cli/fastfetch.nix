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
        type = "kitty";
      };
      display = {
        color = "blue";
      };
      modules = [
        "colors"
        "break"
        "host"
        "os"
        "editor"
        "separator"
        "kernel"
        "shell"
        "terminal"
        "separator"
        "cpu"
        "memory"
      ];
    };
  };
}
