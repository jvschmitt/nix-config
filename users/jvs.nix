{ config, pkgs, ... }:
{

  sops.secrets = {
    user-password = {
      key = "user/password";
    };
  };

  users.users.jvs = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "users"
      "video"
      "plugdev"
      "dialout"
    ];
    hashedPasswordFile = config.sops.secrets.user-password.path;
    shell = pkgs.bash;
  };

}
