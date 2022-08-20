{ config, pkgs, ... }:

{
  imports = [
    ./homebrew.nix
  ];

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
      autohide    = false;
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
    vim
  ];

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

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';

  # Use Touch ID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # The user-friendly name for the system
  networking.computerName = "Starlight";
  networking.hostName     = "HAL";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable  = true;  # default shell on catalina
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
