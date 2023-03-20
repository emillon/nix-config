{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "etienne";
      pkgs = import nixpkgs
      {
        inherit system;
        config.allowUnfree = true;
      };
      common = {
        home.stateVersion = "22.11";
        home.username = "etienne";
        home.homeDirectory = "/home/etienne";
        programs.home-manager.enable = true;
      };
      dev = {
        home.packages =
          with pkgs;
          [
            gh
            opam
          ];

          programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;
            plugins =
              with pkgs.vimPlugins;
              [
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
                let sw=2
              '';
            };

            programs.git = {
              enable = true;
              userEmail = "me@emillon.org";
              userName = "Etienne Millon";
              extraConfig = {
                url = {
                  "git@github.com".pushInsteadOf = "https://github.com/";
                  "git@gist.github.com".pushInsteadOf = "https://gist.github.com/";
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
          };
          x11 = {
            home.packages =
              with pkgs;
              [
                google-chrome
                dmenu
              ];
              home.keyboard.options = [ "compose:rctrl" ];
              home.sessionVariables.BROWSER = "google-chrome-stable";
              xsession.enable = true;
              xsession.windowManager.xmonad = {
                enable = true;
                enableContribAndExtras = true;
              };
            };
          media = {
            home.packages =
              with pkgs;
              [
                yt-dlp
              ];
          };
    in {
      homeConfigurations = {
        "${username}@delpech" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            common
            dev
            media
            x11
            ./delpech.nix
          ];
        };
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            common
            dev
          ];
        };
      };
    };
}
