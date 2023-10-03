{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "etienne";
      pkgs = import nixpkgs {
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
      };
      x11 = {
        home.packages = with pkgs; [ google-chrome dmenu ];
        home.keyboard.options = [ "compose:rctrl" ];
        home.sessionVariables.BROWSER = "google-chrome-stable";
        xsession.enable = true;
        xsession.windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
      wayland = {
        home.packages = with pkgs; [ foot ];
        wayland.windowManager.sway = {
          enable = true;
          config.modifier = "Mod4";
          config.focus.wrapping = "yes";
          config.keybindings = let mod = "Mod4"; # XXX
          in pkgs.lib.mkOptionDefault {
            "${mod}+Shift+Return" = "exec ${pkgs.foot}/bin/foot";
            "${mod}+Shift+c" = "kill";
            "${mod}+q" = "reload";
            "${mod}+Tab" = "focus next";
            "${mod}+Return" = "move right";
            "${mod}+1" = "workspace number 1";
            "${mod}+2" = "workspace number 2";
            "${mod}+3" = "workspace number 3";
            "${mod}+4" = "workspace number 4";
            "${mod}+5" = "workspace number 5";
            "${mod}+6" = "workspace number 6";
            "${mod}+7" = "workspace number 7";
            "${mod}+8" = "workspace number 8";
            "${mod}+9" = "workspace number 9";
            "${mod}+0" = "workspace number 10";
            "${mod}+Shift+1" = "move container to workspace number 1";
            "${mod}+Shift+2" = "move container to workspace number 2";
            "${mod}+Shift+3" = "move container to workspace number 3";
            "${mod}+Shift+4" = "move container to workspace number 4";
            "${mod}+Shift+5" = "move container to workspace number 5";
            "${mod}+Shift+6" = "move container to workspace number 6";
            "${mod}+Shift+7" = "move container to workspace number 7";
            "${mod}+Shift+8" = "move container to workspace number 8";
            "${mod}+Shift+9" = "move container to workspace number 9";
            "${mod}+Shift+0" = "move container to workspace number 10";
            "${mod}+Left" = "workspace prev";
            "${mod}+Right" = "workspace next";
            "${mod}+Shift+Left" = "move container to workspace prev";
            "${mod}+Shift+Right" = "move container to workspace next";
            "XF86AudioRaiseVolume" =
              "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
            "XF86AudioLowerVolume" =
              "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "${mod}+l" = "exec swaylock";
            "${mod}+space" = "layout toggle splith stacking";
            "${mod}+a" = "focus parent";
            "${mod}+Shift+q" =
              "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
          };
          # set $menu wofi --show run | xargs swaymsg exec --
          # default_border pixel 2
          # include /etc/sway/config-vars.d/*
          # output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill
          #     bindsym $mod+p exec $menu
          #     floating_modifier $mod normal
          # bar {
          #     swaybar_command waybar
          # }
          # include /etc/sway/config.d/*
        };
        services.kanshi.enable = true;
      };
      media = { home.packages = with pkgs; [ yt-dlp ]; };
    in {
      homeConfigurations = {
        "${username}@delpech" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ common dev media x11 wayland ./delpech.nix ];
        };
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ common dev ];
        };
      };
    };
}
