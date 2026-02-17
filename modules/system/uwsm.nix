{ pkgs, ... }:
{
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
        extraArgs = [ "unsupported-gpu" ];
      };
    };
  };
}
