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
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          # Config
          {
            home.stateVersion = "22.11";
            home.username = username;
            home.homeDirectory = "/home/${username}";
            programs.home-manager.enable = true;
          }
          # Common
          {
            home.packages =
              with pkgs;
              [
                gh
                opam
              ];

            programs.neovim = {
              enable = true;
              vimAlias = true;
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
                  let s:merlindir = trim(system('opam var share')) . "/merlin/vim"
                  if isdirectory(s:merlindir)
                  execute "set rtp+=" . s:merlindir
                  execute "helptags " . s:merlindir . "/doc"
                  endif
                  noremap <silent> <C-p> :GFiles<CR>
                  let g:syntastic_ocaml_checkers = ['merlin']
                  let g:syntastic_always_populate_loc_list = 1
                  let g:syntastic_check_on_open = 1
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
            }
          # Graphical
          {
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
          }
          # Per-machine
          {
            programs.autorandr = {
              enable = true;
              profiles = {
                laptop = {
                  fingerprint.eDP-1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";

                  config = {
                    DP-1.enable = false;
                    DP-2.enable = false;
                    HDMI-1.enable = false;
                    HDMI-2.enable = false;
                    eDP-1 = {
                      enable = true;
                      crtc = 0;
                      mode = "2560x1440";
                      position = "0x0";
                      primary = true;
                      rate = "60.01";
                    };
                  };
                };
                office = {
                  fingerprint = {
                    DP-3 = "00ffffffffffff0005e3012735020100141d0103803c22782a8671a355539d250d5054bfef00d1c0b30095008180814081c001010101565e00a0a0a029503020350055502100001e000000ff00474e584b354841303636313031000000fc005132375031420a202020202020000000fd00324c1e631e000a202020202020010502031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000188c0ad090204031200c405500555021000018f03c00d051a0355060883a0055502100001c00000000000000f7";
                    eDP-1 = "00ffffffffffff0006af91d200000000161e0104a51e137803c93ba755499d230d4f5500000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00303c4b4b10010a202020202020000000fe0041554f0a202020202020202020000000fe004231343055414e30322e31200a00ae";
                  };
                  config = {
                    HDMI-1.enable = false;
                    DP-1.enable = false;
                    HDMI-2.enable = false;
                    DP-2.enable = false;
                    HDMI-3.enable = false;
                    DP-4.enable = false;
                    eDP-1.enable = false;
                    DP-3 = {
                      enable = true;
                      crtc = 1;
                      mode = "2560x1440";
                      position = "0x0";
                      rate = "59.95";
                    };
                  };
                };
              };
            };
          }
        ];
      };
    };
}
