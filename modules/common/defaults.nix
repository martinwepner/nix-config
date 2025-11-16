{ pkgs, ... }:
{
  system.defaults = {
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
    };
  };
}
