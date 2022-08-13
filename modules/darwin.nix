{ config, pkgs, ... }:

{
  system.defaults = {
    NSGlobalDomain = {
      AppleFontSmoothing       = 1;
      AppleInterfaceStyle      = "Dark";
      AppleKeyboardUIMode      = 3;
      ApplePressAndHoldEnabled = false;

      InitialKeyRepeat = 12;  # 180ms
      KeyRepeat        = 2;   # 30ms

      NSAutomaticCapitalizationEnabled     = false;
      NSAutomaticDashSubstitutionEnabled   = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled  = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled   = false;
    };

    dock = {
      autohide    = true;
      mru-spaces  = false;
      showhidden  = true;
    };

    finder = {
      AppleShowAllExtensions         = true;
      QuitMenuItem                   = true;
      FXEnableExtensionChangeWarning = false;
    };

    screencapture = { location = "~/Screenshots"; };

    trackpad.Clicking = true;
  };

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    git
    neovim
    vim
  ];

  environment.variables.EDITOR = "nvim";

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "Iosevka"
      ];
    })
  ];

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    casks = [
      # read
      "calibre"
      "spotify"

      # write
      "screenflow"

      # development
      "iterm2"
      "postman"

      # network
      "mullvadvpn"

      # messaging
      "slack"
      "zoom"
    ];

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # The user-friendly name for the system
  networking.computerName = "Starlight";
  networking.hostName     = "HAL";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
