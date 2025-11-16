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
      "chatgpt"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
