{ lib, pkgs, ... }:
{
  programs.vscodiumExtended.extensions = lib.mkAfter [
    pkgs.vscode-marketplace.saoudrizwan.claude-dev
  ];
}
