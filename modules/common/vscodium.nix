{ lib, pkgs, config, ... }:
let
  inherit (lib) mkOption mkDefault types;
  cfg = config.programs.vscodiumExtended;
  vscodiumPackage = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = cfg.extensions;
  };
in
{
  options.programs.vscodiumExtended = {
    extensions = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Extensions to bake into the shared VSCodium build.";
    };
    package = mkOption {
      type = types.package;
      readOnly = true;
      description = "Prebuilt VSCodium with the configured extensions.";
    };
  };

  config = {
    programs.vscodiumExtended.extensions = mkDefault [
      pkgs.open-vsx.pkief.material-icon-theme
      pkgs.open-vsx.jnoortheen.nix-ide
    ];

    programs.vscodiumExtended.package = vscodiumPackage;

    environment.systemPackages = [
      vscodiumPackage
    ];
  };
}
