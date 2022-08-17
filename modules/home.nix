{ config, pkgs, lib, ... }:

{
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    any-nix-shell
    htop
    pgcli
    nodejs-16_x
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
