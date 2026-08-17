{ config, lib, ... }:
let
  socket = "Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
in
{
  options.local.useSecretive = {
    enable = lib.mkEnableOption "Add secretive integration";
  };
  config = lib.mkIf config.local.useSecretive.enable {
    home.sessionVariables.SSH_AUTH_SOCK = "$HOME/${socket}";
    programs.ssh.settings."*".IdentityAgent = "~/${socket}";
  };
}
