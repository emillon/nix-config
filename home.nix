{ home-manager, pkgs }:
let
  username = "etienne";
  config = modules:
    home-manager.lib.homeManagerConfiguration { inherit modules pkgs; };
in
{
  "${username}@delpech" =
    config [
      ./modules/common
      ./modules/dev
      ./modules/media.nix
      ./modules/x11.nix
      ./modules/ocaml
      ./machines/delpech.nix
    ];
  "${username}@LAPTOP-P2CLQ61L" =
    config [
      ./modules/common
      ./modules/dev
      ./modules/media.nix
      ./machines/delpech-wsl.nix
    ];
  ${username} = config [
    ./modules/common
    ./modules/dev
  ];
}
