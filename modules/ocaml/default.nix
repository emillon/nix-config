{ pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p:
        [
          p.cram
          p.dune
          p.menhir
          p.mld
          p.ocaml
          p.ocaml-interface
        ]))
    ];
    extraConfig = builtins.readFile ./nvim.vim;
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };

  programs.opam = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };
}
