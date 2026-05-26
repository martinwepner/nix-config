{ self, lib, ... }:
{
  imports = [
    self.darwinModules.common
    ./dock.nix
    ./homebrew.nix
    ./packages.nix
  ];

  networking.hostName = "studio";
}
