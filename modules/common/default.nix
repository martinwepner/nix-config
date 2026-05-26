{ self, ... }:
{
  imports = [
    ./nixpkgs.nix
    ./nix-settings.nix
    ./packages.nix
    ./homebrew.nix
    ./fonts.nix
    ./defaults.nix
    ./aliases.nix
    ./system.nix
  ];
}
