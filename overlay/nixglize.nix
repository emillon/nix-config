final: prev:
let
  pkgs = prev;
  nixGL = pkgs.nixgl.nixGLIntel;
  nixglize = pkg:
    let
      wrapped = pkgs.writeShellScriptBin pkg.pname ''
        exec ${nixGL}/bin/nixGLIntel ${pkgs.lib.getExe pkg} "$@"
      '';
    in
    pkgs.symlinkJoin {
      name = pkg;
      paths = [ wrapped pkg ];
    };
in
{ alacritty = nixglize pkgs.alacritty; }
