{ pkgs }:
{
  home.packages = with pkgs; [ gh ];

  programs.opam = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

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
      ]))
      gitsigns-nvim
    ];
    extraConfig = builtins.readFile ./nvim.vim;
    extraLuaConfig = builtins.readFile ./nvim.lua
      + pkgs.ocamlPackages.okra.okra-vim-conf;
  };

  programs.git = {
    enable = true;
    userEmail = "me@emillon.org";
    userName = "Etienne Millon";
    extraConfig = {
      url = {
        "git@github.com:".pushInsteadOf = "https://github.com/";
        "git@gist.github.com:".pushInsteadOf = "https://gist.github.com/";
      };
      merge.conflictstyle = "diff3";
      commit.verbose = true;
      pull.ff = "only";
      rerere.enabled = true;
      interactive.singlekey = true;
      init.defaultBranch = "main";
    };
  };

  programs.tmux.enable = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    history = {
      save = 100000;
      size = 100000;
    };
    shellAliases = {
      ls = "ls -F --color=auto";
      ":e" = "vim";
      ":q" = "exit";
    };
    initExtra = builtins.readFile ./init.zsh;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
