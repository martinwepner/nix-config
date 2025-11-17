{ lib, ... }:
{
  homebrew = {
    brews = lib.mkAfter [
      "llama.cpp"
    ];
    casks = lib.mkAfter [
      "nvidia-geforce-now"
      "lm-studio"
      "crossover"
      "docker-desktop"
      "codex"
      "claude-code"
      "chatgpt"
      "llamabarn"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };
}
