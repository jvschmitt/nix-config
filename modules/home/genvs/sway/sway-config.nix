{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{

  wayland.windowManager.sway = {
    enable = true;
    systemd.variables = [ "--all" ];
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        { command = "swaymsg workspace number 1"; }
        { command = "swaybg -i /home/jvs/nix-config/home/wallpaper.jpg"; }
        { command = "autotiling-rs"; }
      ];

      bars = [ ];

      input = {
        "type:keyboard" = {
          xkb_layout = "br,us";
          xkb_variant = "abnt2";
          xkb_options = "rctrl:nocaps,grp:ctrl_space_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          click_method = "button_areas";
        };
      };

      keybindings =
        let
          mod = "Mod4";
          act = "Alt";
        in
        {

          "${mod}+Space" = "exec wofi";

          "${mod}+a" = "exec kitty yazi";
          "${mod}+e" = "exec emacs";
          "${mod}+f" = "exec firefox";
          "${mod}+t" = "exec kitty";
          "${mod}+o" = "exec obsidian";
          "${mod}+z" = "exec zen-twilight";

          "${act}+Space" = "exec pgrep waybar && pkill waybar || waybar &";

          "${act}+x" = "kill";
          "${act}+f" = "fullscreen";

          "${act}+c" = "sticky toggle";

          "${act}+a" = "focus left";
          "${act}+s" = "focus down";
          "${act}+w" = "focus up";
          "${act}+d" = "focus right";

          "${act}+Shift+d" = "resize shrink width 10 px or 10 ppt";
          "${act}+Shift+w" = "resize grow height 10 px or 10 ppt";
          "${act}+Shift+s" = "resize shrink height 10 px or 10 ppt";
          "${act}+Shift+a" = "resize grow width 10 px or 10 ppt";

          "${act}+left" = "move left";
          "${act}+down" = "move down";
          "${act}+up" = "move up";
          "${act}+right" = "move right";

          "${act}+1" = "workspace number 1";
          "${act}+2" = "workspace number 2";
          "${act}+3" = "workspace number 3";
          "${act}+4" = "workspace number 4";
          "${act}+5" = "workspace number 5";
          "${act}+6" = "workspace number 6";
          "${act}+7" = "workspace number 7";
          "${act}+8" = "workspace number 8";
          "${act}+9" = "workspace number 9";
          "${act}+0" = "workspace number 10";

          "${act}+Shift+1" = "move container to workspace number 1";
          "${act}+Shift+2" = "move container to workspace number 2";
          "${act}+Shift+3" = "move container to workspace number 3";
          "${act}+Shift+4" = "move container to workspace number 4";
          "${act}+Shift+5" = "move container to workspace number 5";
          "${act}+Shift+6" = "move container to workspace number 6";
          "${act}+Shift+7" = "move container to workspace number 7";
          "${act}+Shift+8" = "move container to workspace number 8";
          "${act}+Shift+9" = "move container to workspace number 9";
          "${act}+Shift+0" = "move container to workspace number 10";

          "${act}+F1" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%";
          "${act}+F2" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "${act}+F3" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";

          "${act}+F6" = "exec brightnessctl set -- -10%";
          "${act}+F7" = "exec brightnessctl set -- +10%";

        };

      window = {
        border = 0;
        titlebar = false;
      };

    };
  };

  home.packages = with pkgs; [
    autotiling-rs
    swaybg
  ];

}
