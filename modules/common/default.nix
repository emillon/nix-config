{ config, lib, pkgs, ... }:
{
  home.stateVersion = "22.11";
  home.username = lib.mkDefault "etienne";
  home.homeDirectory =
    let username = config.home.username; in
    if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  programs.home-manager.enable = true;
}
