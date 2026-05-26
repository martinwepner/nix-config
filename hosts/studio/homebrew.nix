{ lib, ... }:
{
  homebrew = {
    brews = lib.mkAfter [
      "wget"
      "cmake"
      {
        name = "node@24";
        link = true;
      }
      "uv"
      "libomp"
      "pnpm"
      "biome"
      "hf"
    ];
    casks = lib.mkAfter [
      "nvidia-geforce-now"
      "crossover"
      "orbstack"
      "claude-code"
      "claude"
      "visual-studio-code"
      "arc"
      "codex"
      "codex-app"
      "utm"
      "lm-studio"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "iMovie" = 408981434;
      "FluxForge Studio" = 6758351212;
      "XCode" = 497799835;
      # "DrawThings" = 6444050820;
    };
  };
}
