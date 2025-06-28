{ pkgs, ... }:
let
  captureDisplays = pkgs.writeShellScriptBin "wl-capture-displays" ''
    ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
  captureDisplay = pkgs.writeShellScriptBin "wl-capture-display" ''
    ${pkgs.grim}/bin/grim -o "$(${pkgs.slurp}/bin/slurp -o -f "%o")" - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
  captureRegion = pkgs.writeShellScriptBin "wl-capture-region" ''
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
in
{
  home.packages = [
    captureDisplay
    captureDisplays
    captureRegion
    pkgs.grim
    pkgs.slurp
  ];
}
