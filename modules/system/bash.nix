{ pkgs, username, ... }:
{

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild-laptop = "sudo su && nixos-rebuild test --flake /home/${username}/nix-config/.#laptop && nixos-rebuild switch --flake /home/${username}/nix-config/.#laptop && su ${username}";
      rebuild-server = "sudo su && nixos-rebuild test --flake /home/${username}/nix-config/.#server && nixos-rebuild switch --flake /home/${username}/nix-config/.#server && su ${username}";
    };
  };

}
