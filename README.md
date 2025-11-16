# nix-config

Personal Nix-darwin configuration.

## Important commands
- `sudo darwin-rebuild build --flake .#studio` — compiles the system without switching, useful to validate changes.
- `sudo darwin-rebuild switch --flake .#studio` — builds and activates the current flake configuration on the machine.
- `darwin-rebuild switch --flake .#studio --dry-run` — shows what would change when switching, without touching the system.
- `sudo darwin-rebuild switch --flake .#studio --rollback` — roll back to the previous generation if a deployment misbehaves.
- `nix flake update` — refresh pinned inputs (run with a clean worktree).
- `nix flake check` — optional consistency check if you add tests or formatters to the flake outputs.
- `darwin-rebuild --list-generations` — inspect historical system generations so you can roll back when needed.
- `sudo nix-collect-garbage --delete-older-than 30d` — drop generations older than 30 days and clean the store (adjust the retention window as needed).
- `nix-store --gc` — reclaim space from unreachable store paths after pruning generations.
- `nix store optimise` — deduplicate identical files in the store to save disk usage (macOS 10.13+).
