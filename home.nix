{ home-manager, pkgs }:
let
  username = "etienne";
  config = module:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ module ];
    };
in
{
  "${username}@delpech" = config ./machines/delpech.nix;
  "${username}@LAPTOP-P2CLQ61L" = config ./machines/delpech-wsl.nix;
  ${username} = config ./machines/generic.nix;
}
