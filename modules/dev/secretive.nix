{ config, lib, ... }:
{
  options.local.useSecretive = {
    enable = lib.mkEnableOption "Add secretive integration";
  };
  config.home.sessionVariables = lib.mkIf config.local.useSecretive.enable {
    SSH_AUTH_SOCK = "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  };
}
