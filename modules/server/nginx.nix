{ pkgs, ... }:
let

  webIndex = "index.php";

in
{

  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      enableACME = false;
      forceSSL = false;
      root = "/data/www/home";
      locations."/" = {
        extraConfig = ''
          index ${webIndex};
          try_files $uri $uri/ =404;
        '';
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  systemd.tmpfiles.rules = [
    "d /data 0755 root root - -"
    "d /data/www 0755 root root - -"
    "d /data/www/home 0755 root root - -"
    "f /data/www/home/index.html 0755 root root - - \"<h1>Default</h1>\""
  ];

}
