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
      "iterm2"
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
