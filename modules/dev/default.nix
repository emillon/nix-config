{ pkgs }:
let
  ts-cram =
    let
      src = pkgs.fetchFromGitHub {
        owner = "tjdevries";
        repo = "tree-sitter-cram";
        rev = "8cb450dfc5548b1aed2be5b3cd735c123b6fa6a8";
        hash = "sha256-CcLbZyHNKLA7NoQ3SLWEBCh5Y/dmzcSGQjs6iCrCFVY=";
      };
    in
    {
      grammar = pkgs.tree-sitter.buildGrammar {
        version = "0.0.1";
        inherit src;
        language = "cram";
      };
      highlights = builtins.readFile "${src}/queries/cram/highlights.scm";
      injections = builtins.readFile "${src}/queries/cram/injections.scm";
    };
in
{
  home.packages = with pkgs; [ gh ];

  xdg.configFile = {
    "nvim/queries/cram/highlights.scm".text = ts-cram.highlights;
    "nvim/queries/cram/injections.scm".text = ts-cram.injections;
  };

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
        ts-cram.grammar
      ]))
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
