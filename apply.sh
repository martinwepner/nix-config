#!/bin/zsh
set -e

nix flake update
sudo darwin-rebuild switch --flake .#studio
