{ config, lib, ... }:
{
  options.local.useHomebrew = {
    enable = lib.mkEnableOption "Add homebrew integration";
  };
  config.programs.zsh.initContent = lib.mkIf config.local.useHomebrew.enable (lib.mkOrder 1000 ''
    export PATH="/opt/homebrew/bin:$PATH"
  '');
}
