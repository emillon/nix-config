{ pkgs }: {
  home.packages = with pkgs; [ gh nixfmt ];

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
    ];
    extraConfig = ''
      let mapleader=","
      let maplocalleader=","
      nnoremap <silent> <C-p> <cmd>Telescope git_files<cr>
      nmap <LocalLeader>f :Neoformat<cr>
      colorscheme catppuccin
      inoremap jk <esc>
      map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
      map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
      let g:merlindir = trim(system('dirname $(command -v ocamlmerlin)')) . "/../share/merlin/vim"
      if isdirectory(g:merlindir)
      execute "set rtp+=" . g:merlindir
      "execute "helptags " . g:merlindir . "/doc"
      endif
      let g:syntastic_ocaml_checkers = ['merlin']
      let g:syntastic_always_populate_loc_list = 1
      let g:syntastic_check_on_open = 1
      let g:syntastic_rst_checkers = ['sphinx']
      set sw=4
      set expandtab
      set ignorecase
      set smartcase
      set signcolumn=yes:1
      nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
    '';
    extraLuaConfig = ''
      if vim.fn.isdirectory(vim.g.merlindir) == 0 then
        if vim.fn.executable('ocamllsp') == 1 then
          require'lspconfig'.ocamllsp.setup{}
        end
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover, { buffer = ev.buf })
          end,
        })
      end
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
