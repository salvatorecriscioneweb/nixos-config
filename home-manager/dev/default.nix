{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    android-studio
  ];

  programs.btop.enable = true;
}
