{ config, pkgs, lib, ... }:

{
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    any-nix-shell
    htop
    pgcli
    neovim-nightly
    nodejs-16_x
    terraform-ls
    tflint
    texlive.combined.scheme-full
    tmux
  ];

  programs.emacs = {
    enable = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "ls -F -h --color -v";
      ll = "ls -l";
      ".." = "cd ..";
    };

    interactiveShellInit = ''
      any-nix-shell fish --info-right | source

      set -x EDITOR "nvim"
    '';
  };

  xdg.configFile."fish/conf.d/colorscheme.fish".source    = ../config/fish/tokyonight_night.fish;
  xdg.configFile."fish/completions/terraform.fish".source = ../config/fish/completions/terraform.fish;

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
