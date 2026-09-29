{ home-manager, pkgsFor }:
let
  username = "etienne";
  config = system: module:
    home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor system;
      modules = [ module ];
    };
in
{
  "${username}@delpech" = config "x86_64-linux" ./machines/delpech.nix;
  "${username}@LAPTOP-P2CLQ61L" = config "x86_64-linux" ./machines/delpech-wsl.nix;
  ${username} = config "x86_64-linux" ./machines/generic.nix;
}
