{ lib, pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./gh.nix
    ./git.nix
    ./homebrew.nix
    ./nvim.nix
    ./secretive.nix
    ./zsh.nix
  ];

  programs.tmux.enable = true;

  programs.zsh.initContent = lib.mkOrder 1000 ''
    export LS_COLORS=$(${lib.getExe pkgs.vivid} generate catppuccin-mocha)
  '';

  programs.fd.enable = true;
  programs.ripgrep.enable = true;
}
