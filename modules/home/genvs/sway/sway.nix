{
  config,
  pkgs,
  lib,
  ...
}:
let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-enviroment";
    executable = true;

    text = ''
      dbus-update-activation-enviroment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in
{

  environment.systemPackages = with pkgs; [
    swaylock
    grim
    slurp
    wl-clipboard
    mako
  ];

  services.dbus.enable = true;

  programs = {
    light.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

}
