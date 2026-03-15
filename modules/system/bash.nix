{ pkgs, username, ... }:
{

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild-laptop = "sudo nixos-rebuild test --flake /home/${username}/nix-config/.#laptop && nixos-rebuild switch --flake /home/${username}/nix-config/.#laptop";
      rebuild-server = "sudo nixos-rebuild test --flake /home/${username}/nix-config/.#server && nixos-rebuild switch --flake /home/${username}/nix-config/.#server";
    };
  };

}
