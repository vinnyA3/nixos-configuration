{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fd.enable = true;

  programs.jq.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Yea, these last 3 tools aren't necessary development tools ... we'll split these later
  programs.btop = {
    enable = true;
    settings = {
      # noctalia theme is automatically provided by noctalia's theming templates!
      color_theme = "noctalia";
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.imv.enable = true;

  programs.yazi.enable = true;

  programs.opencode = {
    enable = true;
    settings = {
      # per homemanager docs, $schema should already be added
      autoupdate = false;
      theme = "nocatlia";
    };
  };

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
    settings = {
      updates = {
        auto_update = true;
      };
    };
  };

  home.packages = with pkgs; [
    neovim # enabled in modules/common too
    bat
    ripgrep
    ffmpeg
    yt-dlp
    pinentry-curses
    localsend
    python3
    libnotify
    zip
    unzip
    playerctl
    wl-clipboard
    glib
    lxappearance
    bluetui
    adw-gtk3
    nwg-look
    pinta
  ];
}
