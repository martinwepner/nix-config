{ lib, ... }:
{
  homebrew = {
    casks = lib.mkAfter [
      "nvidia-geforce-now"
      "lm-studio"
      "crossover"
      "docker-desktop"
      "codex"
      "claude-code"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
