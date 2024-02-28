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
      let g:syntastic_rst_checkers = ['sphinx']
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
    initExtra = ''
      setopt autopushd
      stty -ixon
      mdcd ()
      {
        mkdir -p "$1"
        cd "$1"
      }
      alias -s -- pdf=zathura
      if [ -d ~/.opam ] ; then
          eval `opam config env`
      fi
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete _correct _approximate
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*' menu select=2
      eval "$(dircolors -b)"
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' list-colors ""
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list "" 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
      zstyle ':completion:*' menu select=long
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true

      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
      export EDITOR=vim
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '\C-x\C-e' edit-command-line
      bindkey '^[[1;5D' emacs-backward-word
      bindkey '^[[1;5C' emacs-forward-word
      autoload -Uz promptinit
      promptinit
      prompt walters
      autoload -Uz vcs_info
      zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
      zstyle ':vcs_info:*' unstagedstr '%F{yellow}•%f'
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' formats ' [%b%u%c]'
      zstyle ':vcs_info:*' actionformats ' [%b%u%c]'
      precmd () { vcs_info }
      setopt prompt_subst
      promptcolor=''${host_color:-cyan}
      PROMPT='%F{$promptcolor} %~$vcs_info_msg_0_ %# %f'
      RPROMPT=""
    '';
  };
}
