{ config, ... }:
{
  system.defaults.dock.persistent-apps = [
    "/Applications/Safari.app"
  ];

  system.defaults.dock.persistent-others = [
    {
      folder = {
        path = "/Users/martinwepner/Downloads";
        arrangement = "date-added";
        displayas = "stack";
        showas = "automatic";
      };
    }
  ];
}
