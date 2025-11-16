{ self, lib, ... }:
{
  imports = [
    self.darwinModules.common
    ./dock.nix
    ./homebrew.nix
    ./packages.nix
    ./vscodium.nix
  ];

  networking.hostName = "studio";
}
