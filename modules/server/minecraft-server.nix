{ config, pkgs, ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = {
      # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
      #username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
      #username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
    };
    serverProperties = {
      server-port = 25565;
      difficulty = 3;
      gamemode = 0;
      max-players = 10;
      online-mode = false;
      motd = "Servidor NixOS de JVS";
      white-list = false;
      allow-cheats = false;
      enforce-secure-profile = false;
      force-gamemode = true;
      view-distance = 12;
      level-name = "Anarquia";
      level-seed = "";
      spawn-protection = 0;

      #enable-rcon = true;
      #"rcon.port" = 25575;
      #"rcon.password" = builtins.readFile /data/rcon-passwd;
    };
    package = pkgs.papermc;
    dataDir = "/var/lib/minecraft";
    jvmOpts = "-Xms2048M -Xmx4096M";
  };

  /*
      Template de instalação de plugins

      if [ ! -f /var/lib/minecraft/plugins/ ]; then
      ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/ \
          ""
      fi
  */

  environment.systempackages = with pkgs; [ wget ];
  systemd.services.minecraft-server.prestart = ''
    cp -f ${
      pkgs.runcommand "icon.png" { nativebuildinputs = [ pkgs.imagemagick ]; } ''
        convert ${
          pkgs.fetchurl {
            url = "https://minecraft.wiki/images/book_and_quill_je2_be2.png";
            sha256 = "0a3yb9wkqhmanm4zwz2bpgdl2aa8x7gd44wajl3ijrk97d0h8n92";
          }
        } -resize 64x64! $out
      ''
    } /var/lib/minecraft/server-icon.png

    mkdir -p /var/lib/minecraft/plugins

    if [ ! -f /var/lib/minecraft/plugins/skinsrestorer.jar ]; then
    ${pkgs.curl}/bin/curl -l -o /var/lib/minecraft/plugins/skinsrestorer.jar \
        "https://cdn.modrinth.com/data/tsls8py5/versions/oicdtx5p/skinsrestorer.jar"
    fi

    if [ ! -f /var/lib/minecraft/plugins/voicechat-bukkit-2.6.7.jar ]; then
    ${pkgs.curl}/bin/curl -l -o /var/lib/minecraft/plugins/voicechat-bukkit-2.6.7.jar \
        "https://hangarcdn.papermc.io/plugins/henkelmax/simplevoicechat/versions/bukkit-2.6.7/paper/voicechat-bukkit-2.6.7.jar"
    fi

  '';
  networking.firewall = {
    allowedTCPPorts = [ 25575 ];
    allowedUDPPorts = [ 24454 ]; # 24454: voicechat;
  };
}
