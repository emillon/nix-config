{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      molokai
      vim-nix
      fugitive
      rhubarb
      neoformat
      nvim-lspconfig
      nerdcommenter
      syntastic
      telescope-nvim
      catppuccin-nvim
      oil-nvim
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.ocaml
        p.ocaml-interface
        p.markdown
        p.markdown-inline
        p.nix
        p.lua
        p.javascript
        p.cram
        p.dune
        p.query
        p.mld
        p.html
        p.latex
        p.menhir
      ]))
      gitsigns-nvim
    ];
    extraConfig = builtins.readFile ./nvim.vim;
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };
}
