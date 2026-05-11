{ pkgs, ... }:
let
  virtualisation_username = "jvs";
in
{

  virtualisation = {
    libvirtd.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
    freerdp
    winboat
  ];

  users = {
    extraGroups.libvirtd.members = [ "${virtualisation_username}" ];
    extraGroups.kvm.members = [ "${virtualisation_username}" ];
    groups.docker = {
      gid = 131;
    };
  };
}
