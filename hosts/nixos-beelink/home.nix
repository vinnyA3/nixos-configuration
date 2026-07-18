{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
    ../../home/common.nix
    ../../home/xdg.nix
    ../../home/terminal.nix
    ../../home/shell.nix
    ../../home/tmux.nix
    ../../home/git.nix
    ../../home/ssh.nix
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.noctalia = {
    enable = true;
    settings = {
      wallpaper = {
        enable = true;
      };
    };
  };

  programs.zathura = {
    enable = true;
    # noctalia theme is automatically provided by noctalia's theming templates!
    extraConfig = ''
      include noctaliarc
    '';
  };

  programs.btop = {
    enable = true;
    settings = {
      # noctalia theme is automatically provided by noctalia's theming templates!
      color_theme = "noctalia";
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.fd.enable = true;

  programs.jq.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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

  programs.imv.enable = true;

  programs.yazi.enable = true;
}
