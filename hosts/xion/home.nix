{ inputs, lib, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.umbriel.homeModules.default
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
    # this *should* be setup by umbriel
    # ../../home/xwayland.nix
    ../../home/ssh.nix
    ../../home/launcher.nix
    ../../home/system-sounds.nix
    ../../home/umbriel.nix
  ];

  home = {
    sessionVariables = {
      XCURSOR_THEME = "mori-calliope-x";
      XCURSOR_SIZE = "24";
    };
  };

  # umbriel wm overrides
  programs.umbriel = {
    settings = {
      output = lib.mkForce {
        "HDMI-A-1" = {
          hdr = "auto";
          position = [1440 0];
          scale = 1.0;
          focus_at_startup = true;
        };

        "DP-1" = {
          position = [0 0];
          scale = 1.0;
          transform = "90";
        };
      };

      keybinds = {
        "Mod+Space" = lib.mkForce "spawn:vicinae toggle";
      };

      input = {
        cursor = {
          theme = "mori-calliope-x";
          size = 24;
        };
      };
    };
  };
}
