{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ../../home/common.nix
    ../../home/fonts.nix
    ../../home/xdg.nix
    ../../home/terminal.nix
    ../../home/shell.nix
    ../../home/tmux.nix
    ../../home/git.nix
    ../../home/development.nix
    ../../home/browsers.nix
    ../../home/noctalia.nix
    ../../home/zathura.nix
    ../../home/entertainment.nix
    ../../home/ssh.nix
  ];

  home.packages = with pkgs; [
    lm_sensors
    brightnessctl
    ddcutil
    rofi
  ];
}
