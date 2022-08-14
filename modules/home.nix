{ config, pkgs, lib, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    sha256 = "00kmqz3davv6myiamxwcl6bwmrird94s50kxgpk94hql5k21z3dr";
  }) {
    doomPrivateDir = ./doom.d;  
  };

in {
  home.packages = with pkgs; [
    any-nix-shell
    doom-emacs
    htop
    nodejs-16_x
    pgcli
    terraform-ls
    tflint
    texlive.combined.scheme-full
    tmux
  ];

  programs.git = {
    enable = true;
    userName = "Winston Troughton";
    userEmail = "winston@troughton.net";
    extraConfig = {
      init = { defaultBranch = "main"; };
      github = { user = "wtroughton"; };
    };
  };

  xdg.configFile."tmux/tmux.conf".text = ''
    # mouse support
    set -g mouse on
    set -g default-terminal "xterm-256color"
    # Overrides the default color
    set-option -ga terminal-overrides ",xterm-256color:Tc"
  '';

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "22.05";
}
