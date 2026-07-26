{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };
}
