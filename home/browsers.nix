{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override { enableWideVine = true; };
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-features=WaylandWindowDecorations,WebUIDarkMode"
      "--force-dark-mode"
    ];
  };

  home.packages = with pkgs; [
    qutebrowser
  ];
}
