{ pkgs }: {
  home.packages = with pkgs; [ google-chrome dmenu alacritty obsidian ];
  home.keyboard.options = [ "compose:rctrl" ];
  home.sessionVariables.BROWSER = "google-chrome-stable";
  xsession.enable = true;
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };
}
