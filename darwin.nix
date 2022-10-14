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
    ibm-plex
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

  services.yabai = {
    enable = false;
    package = pkgs.yabai;
    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_border                = "on";
      window_border_placement      = "inset";
      window_border_width          = 2;
      window_border_radius         = 3;
      active_window_border_topmost = "off";
      window_topmost               = "on";
      window_shadow                = "float";
      active_window_border_color   = "0xff5c7e81";
      normal_window_border_color   = "0xff505050";
      insert_window_border_color   = "0xffd75f5f";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 36;
      bottom_padding               = 10;
      left_padding                 = 10;
      right_padding                = 10;
      window_gap                   = 10;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
