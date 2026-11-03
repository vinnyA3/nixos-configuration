{ pkgs, lib, ... }:
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

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
    settings = {
      # per homemanager docs, $schema should already be added
      autoupdate = false;
    };

    tui = {
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    # Pkgs listed here for reference - mostly added project level (ie. proj's flake.nix)
    # extraPackages = with pkgs; [
      # === lsps
      # gopls
      # lua-language-server
      # marksman
      # typescript-language-server
      # stylua
      # === linters
      # eslint_d
      # markdownlint-cli2
      # === formatters
      # golines
      # markdown-toc
      # nixfmt
      # prettier
      # shfmt
    # ];
  };

  # don't generate an nvim init
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  home.packages = with pkgs; [
    gcc
    gnumake
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
    mermaid-cli
    imagemagick
  ];
}
