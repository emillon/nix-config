{ pkgs }: {
  home.stateVersion = "22.11";
  home.username = "etienne";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/etienne" else "/home/etienne";
  programs.home-manager.enable = true;
}
