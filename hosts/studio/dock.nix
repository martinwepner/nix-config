{ config, ... }:
{
  system.defaults.dock.persistent-apps = [
    "/Applications/Safari.app"
    "${config.programs.vscodiumExtended.package}/Applications/VSCodium.app"
  ];

  system.defaults.dock.persistent-others = [
    "/Users/martinwepner/Downloads"
  ];
}
