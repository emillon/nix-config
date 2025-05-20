{ home-manager, pkgs }:
let
  username = "etienne";
  common = import ./modules/common { inherit pkgs; };
  dev = import ./modules/dev { inherit pkgs; };
  x11 = import ./modules/x11.nix { inherit pkgs; };
  wayland = import ./modules/wayland.nix { inherit pkgs; };
  media = { home.packages = with pkgs; [ pirate-get yt-dlp ]; };
  work = { programs.neovim.plugins = [ pkgs.ocamlPackages.okra.okra-vim ]; };
  config = modules:
    home-manager.lib.homeManagerConfiguration { inherit modules pkgs; };
in
{
  "${username}@delpech" =
    config [ common dev media x11 wayland ./machines/delpech.nix work ];
  "${username}@LAPTOP-P2CLQ61L" =
    config [ common dev media ./machines/delpech-wsl.nix work ];
  ${username} = config [ common dev ];
}
