# rebuild: darwin-rebuild switch --flake .#studio  
{
  description = "Nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # VSCode Extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-vscode-extensions, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }:
  let
    # Define VSCodium with extensions
    vscodium-with-extensions = pkgs: pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = [
        # open-vsx
        # vscode-marketplace
        pkgs.open-vsx.saoudrizwan.claude-dev
        pkgs.open-vsx.pkief.material-icon-theme
        pkgs.open-vsx.jnoortheen.nix-ide
      ];
    };
    
    configuration = { pkgs, config, ... }: {
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.nix-vscode-extensions.overlays.default
        ];
      };

      networking = {
        hostName = "studio";
      };

      nix = {
        settings = { 
          experimental-features = "nix-command flakes";
        };
      };

      environment = {
        systemPackages = [
          pkgs.mkalias # to create aliases and find applications using cmd+space

          pkgs.mas
          (vscodium-with-extensions pkgs) # VSCodium with extensions
          pkgs.istatmenus
          pkgs.oh-my-posh
          pkgs.warp-terminal
          pkgs.gh
          pkgs.curl
        ];
      };

      homebrew = {
        enable = true;
        brews = [];
        casks = [
          # "affine"
          "nvidia-geforce-now"
          "lm-studio"
        ];
        masApps = {
          "Tailscale" = 1475387142;
          "Amphetamine" = 937984704;
          "Pages" = 409201541;
          "Telegram" = 747648890;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };
      
      fonts= {
        packages = [
          pkgs.nerd-fonts.jetbrains-mono
        ];
      };

      environment.shellInit = ''
        eval "$(oh-my-posh init asd)"
      '';

      system = {
        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 6;
        configurationRevision = self.rev or self.dirtyRev or null;

        defaults = {
          loginwindow.GuestEnabled = false;
          trackpad = {
            TrackpadThreeFingerDrag = true;
            Clicking = true;
          };
          
          finder = { 
            FXPreferredViewStyle = "clmv";
            NewWindowTarget = "Home";
          };
          
          NSGlobalDomain = {
            AppleICUForce24HourTime = true;
            AppleInterfaceStyle = "Dark";
          };

          dock = { 
            orientation = "left";
            show-recents = false;
            persistent-apps = [
              "/Applications/Safari.app"
              # "/System/Applications/Utilities/Terminal.app"
              "${pkgs.warp-terminal}/Applications/Warp.app"
              "${(vscodium-with-extensions pkgs)}/Applications/VSCodium.app"
            ];
            persistent-others = [
              "/Users/martinwepner/Downloads"
            ];
          };
        };

        # Apps Aliases
        activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in
          pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
              '';
        };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#studio
    darwinConfigurations.studio = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "martinwepner";

            # Optional: Declarative tap management
            taps = {
              "homebrew/core" = homebrew-core;
              "homebrew/cask" = homebrew-cask;
              "homebrew/bundle" = homebrew-bundle;
            };

            # Optional: Enable fully-declarative tap management
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = false;
          };
        }
      ];
    };
  };
}
