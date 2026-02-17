{

  description = "janSitto nix-config multi-host flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      silentSDDM,
      nvf,
      zen-browser,
      ...
    }@inputs:
    {
      nixosModules = {

        # Home-manager & Home config
        home = import ./home/home-manager.nix;
        home-config = import ./home/home-config.nix;

        # Modules
        gnome = import ./modules/home/genvs/gnome/gnome.nix;
        plasma = import ./modules/home/genvs/plasma/plasma.nix;
        hyprland = import ./modules/home/genvs/hyprland/hyprland.nix;
        sway = import ./modules/home/genvs/sway/sway.nix;
        fonts = import ./modules/fonts.nix;
        programs = import ./modules/programs/programs.nix;
        vscodium = import ./modules/programs/editors/vscodium.nix;
        qt = import ./modules/programs/qt.nix;
        firefox = import ./modules/programs/firefox.nix;
        steam = import ./modules/programs/steam.nix;
        virtualisation = import ./modules/virtualisation.nix;

        # Server Stuff
        adguardhome = import ./modules/server/adguardhome.nix;
        duckdns = import ./modules/server/duckdns.nix;
        nginx = import ./modules/server/nginx.nix;
        openssh = import ./modules/server/openssh.nix;
        samba = import ./modules/server/samba.nix;
        minecraft-server = import ./modules/server/minecraft-server.nix;
        screen-off = import ./modules/server/screen-off.nix;
        tailscale-server = import ./modules/server/tailscale-server.nix;
        syncthing = import ./modules/server/syncthing.nix;

        # Secrets/Cryptography
        sops = import ./modules/system/sops.nix;

        # System
        grub = import ./modules/system/bootloaders/grub.nix;
        sddm = import ./modules/system/display-managers/sddm.nix;
        greetd = import ./modules/system/display-managers/greetd.nix;
        nvidia = import ./modules/system/graphics/nvidia.nix;
        nvidia-nouveau = import ./modules/system/graphics/nvidia-nouveau.nix;
        bluetooth = import ./modules/system/bluetooth.nix;
        garbage-collector = import ./modules/system/garbage-collector.nix;
        io-utils = import ./modules/system/io-utils.nix;
        pipewire = import ./modules/system/pipewire.nix;
        power = import ./modules/system/power.nix;
        network = import ./modules/system/network/network.nix;
        localhost = import ./modules/system/network/localhost.nix;
        security = import ./modules/system/security.nix;
        timezone = import ./modules/system/timezone.nix;
        xdg = import ./modules/system/xdg.nix;
        xserver = import ./modules/system/xserver.nix;
        tailscale = import ./modules/system/network/tailscale.nix;
        zerotier = import ./modules/system/network/zerotier.nix;

        # Users
        user-jvs = import ./users/jvs.nix;

      };
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = with self.nixosModules; [
            ./hosts/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            home
            greetd
            sway
            network
            localhost
            grub
            timezone
            xdg
            qt
            xserver
            security
            nvidia-nouveau
            bluetooth
            garbage-collector
            io-utils
            pipewire
            power
            programs
            firefox
            fonts
            virtualisation
            tailscale
            zerotier
            syncthing
            user-jvs
            sops
          ];
          specialArgs = {
            system = "x86_64-linux";
            username = "jvs";
            inherit inputs;
          };
        };
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = with self.nixosModules; [
            ./hosts/server/configuration.nix
            sops-nix.nixosModules.sops
            adguardhome
            grub
            duckdns
            nginx
            openssh
            samba
            io-utils
            tailscale-server
            minecraft-server
            zerotier
            screen-off
            syncthing
            user-jvs
            sops
          ];
          specialArgs = {
            system = "x86_64-linux";
            username = "jvs";
            inherit inputs;
          };
        };
      };
    };
}
