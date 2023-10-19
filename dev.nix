{ pkgs }: {
  home.packages = with pkgs; [ gh opam nixfmt ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      molokai
      vim-nix
      fugitive
      rhubarb
      neoformat
      nvim-lspconfig
      nerdcommenter
      syntastic
    ];
    extraConfig = ''
      let mapleader=","
      let maplocalleader=","
      nnoremap <silent> <C-p> :GFiles<CR>
      nmap <LocalLeader>f :Neoformat<cr>
      colorscheme molokai
      inoremap jk <esc>
      map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
      let g:merlindir = trim(system('opam var share')) . "/merlin/vim"
      if isdirectory(g:merlindir)
      execute "set rtp+=" . g:merlindir
      execute "helptags " . g:merlindir . "/doc"
      endif
      noremap <silent> <C-p> :GFiles<CR>
      let g:syntastic_ocaml_checkers = ['merlin']
      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_check_on_open = 1
      set sw=4
      set expandtab
      set ignorecase
      set smartcase
      nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
    '';
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
}
