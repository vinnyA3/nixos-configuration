{ inputs, ... }:
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
    ../../home/ssh.nix
  ];
}
