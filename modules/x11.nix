{ pkgs }: {
  home.packages = with pkgs; [ google-chrome dmenu alacritty kitty ];
  home.keyboard.options = [ "compose:rctrl" ];
  home.sessionVariables.BROWSER = "google-chrome-stable";
  xsession.enable = true;
  xsession.windowManager.command = pkgs.lib.mkForce
    "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.xmonad-with-packages}/bin/xmonad";
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };
}
