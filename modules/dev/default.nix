{ pkgs }:
let lib = pkgs.lib; in
{
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [ gh ];

  programs.opam = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };


  programs.tmux.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza.enable = true;
  programs.bat.enable = true;

  programs.zsh.initContent = lib.mkOrder 1000 ''
    export LS_COLORS=$(${lib.getExe pkgs.vivid} generate catppuccin-mocha)
  '';
}
