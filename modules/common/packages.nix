{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.mkalias
    pkgs.mas
    pkgs.oh-my-posh
    pkgs.gh
  ];
}
