{ pkgs, ... }:
{

  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.noto
    nerd-fonts.hack
  ];

}
