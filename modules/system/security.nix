{ ... }:

{
  # Sudo configuration
  security.sudo.extraConfig = ''
    # Preserve EDITOR environment variable when using sudo
    Defaults env_keep += "EDITOR"
  '';
}
