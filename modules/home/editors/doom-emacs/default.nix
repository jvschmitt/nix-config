{ inputs, pkgs, ... }:
{
  imports = [ inputs.doom-emacs.hmModule ];

  home.packages = with pkgs; [
    nixfmt
    ripgrep
    shellcheck
    fd
    shfmt
  ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      #pkgs.treesit-grammars.with-all-grammars
      pkgs.emacs.pkgs.lsp-bridge
    ];
    doomDir = ./doom.d;
    #tangleArgs = "--all config.org";
    #experimentalFetchTree = true;

  };

}
