{
  config,
  lib,
  pkgs,
  ...
}:
{

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    curl
    jq
    git
    lm_sensors
  ];

  networking.hostName = "nixos-server";

  # Networking
  boot.kernel.sysctl = {
    # This is needed for the tailscale-server.nix exit node to work
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  networking = {

    # Firewall
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        7830
        445
        137
        138
        139
        80
        443
      ];
      allowedUDPPorts = [
        7830
        445
        137
        138
        139
        80
        443
        41641
      ];
    };

    # NAT
    nat = {
      enable = true;
      externalInterface = "enp7s0";
    };

  };

  fileSystems = {
    "/home" = {
      device = "/data/home";
      options = [ "bind" ];
      fsType = "ext4";
    };
    "/var/lib/minecraft" = {
      device = "/data/var/lib/minecraft";
      options = [ "bind" ];
      fsType = "ext4";
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./hardware-configuration.nix
  ];

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.11"; # Did you read the comment?
  };

}
