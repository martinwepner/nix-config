{ lib, pkgs, ... }:
{
  environment.systemPackages = lib.mkAfter [
    pkgs.curl
    pkgs.python312
  ];
}
