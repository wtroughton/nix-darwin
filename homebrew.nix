{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    brewPrefix = "/opt/homebrew/bin";

    brews = [
    ];

    casks = [
      "calibre"
      "emacs"
      "iterm2"
      "affinity-publisher"
      "omnigraffle"
      "postman"

      "eloston-chromium"
      "firefox"
      "mullvadvpn"

      "raycast"
      "screenflow"
      "spotify"
      "slack"
      "zoom"
    ];

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
  };
}
