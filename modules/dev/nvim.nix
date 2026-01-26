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
      plenary-nvim
      catppuccin-nvim
      oil-nvim
      (nvim-treesitter.withPlugins (p:
        [
          p.c
          p.markdown
          p.markdown-inline
          p.nix
          p.lua
          p.javascript
          p.query
          p.html
          p.latex
        ]
      ))
      gitsigns-nvim
    ];
    extraConfig = builtins.readFile ./nvim.vim;
    initLua = builtins.readFile ./nvim.lua;
  };
}
