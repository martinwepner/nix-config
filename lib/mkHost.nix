{ inputs, self }:
path:
let
  inherit (inputs) nix-darwin nix-homebrew homebrew-core homebrew-cask;
in
nix-darwin.lib.darwinSystem {
  modules = [
    path
    nix-homebrew.darwinModules.nix-homebrew
    ({ ... }: {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "martinwepner";
        taps = {
          "homebrew/core" = homebrew-core;
          "homebrew/cask" = homebrew-cask;
        };
        mutableTaps = false;
      };
    })
  ];
  specialArgs = {
    inherit inputs self;
  };
}
