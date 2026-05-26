{ lib, ... }:
{
  environment.variables.HOMEBREW_AUTO_UPDATE_SECS = "0";

  homebrew = {
    enable = true;
    brews = [ 
      "stats"
    ];
    casks = [ ];
    masApps = {
      "Tailscale" = 1475387142;
    };
    greedyCasks = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
