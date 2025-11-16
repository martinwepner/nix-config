{ lib, ... }:
{
  homebrew = {
    enable = true;
    brews = [ ];
    casks = [
      "istat-menus"
    ];
    masApps = {
      "Tailscale" = 1475387142;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
