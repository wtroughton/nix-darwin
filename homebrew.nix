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
      "intellij-idea-ce"
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
      "trezor-suite"
      "zoom"
    ];

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
  };
}
