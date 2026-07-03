{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  user = "qwerty";
  homeDir = "/home/" + user;
  xdgDefaultImageViewer = [ "imv.desktop" ];
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home = {
    # let home manager know what paths it should manage and for who
    username = user;
    homeDirectory = homeDir;
    stateVersion = "25.11";
    shell = {
      enableZshIntegration = true;
    };
  };

  # dots symlinks
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink homeDir + "/.dotfiles/config/hypr";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  xdg = {
    desktopEntries = {
      imv = {
        name = "imv";
        genericName = "lightweight image viewer";
        exec = "imv";
        type = "Application";
        terminal = false;
      };

      chromium = {
        name = "Chromium (Wayland)";
        genericName = "Web Browser";
        exec = "chromium --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
        terminal = false;
        categories = [
          "Network"
          "WebBrowser"
        ];

        mimeType = [
          "text/html"
          "text/xml"
          "application/xhtml+xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      };
    };

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = builtins.listToAttrs (
        map
          (v: {
            name = v;
            value = xdgDefaultImageViewer;
          })
          [
            "image/png"
            "image/jpg"
            "image/jpeg"
            "image/gif"
          ]
      );
    };
  };

  home.packages = with pkgs; [
    neovim
    qutebrowser # check
    bat
    ripgrep
    mpv
    ffmpeg
    yt-dlp
    pass
    pinentry-curses
    localsend
    python3
    libnotify
    zip
    unzip
    playerctl
    xfce.thunar
    adw-gtk3
    wl-clipboard
    glib
    lxappearance
    bluetui
    unstable.cliamp
    unstable.niri
    cava
    nerd-fonts.monaspace
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      wallpaper = {
        enable = true;
        default.path = "$HOME/Pictures/wallpaper/boju-jutsu.png";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = ''
      export EDITOR=nvim
      export SUDO_EDITOR=nvim
      # ripgrep
      export RIPGREP_CONFIG_PATH=$HOME
      # colored, pretty man pages - requires bat (https://github.com/sharkdp/bat) binary
      export MANROFFOPT="-c"
      export MANPAGER="sh -c 'col -bx | bat -l man -p'"
      export PATH=$PATH:$HOME/.local/bin
    '';
    shellAliases = {
      ":q" = "exit";
      vim = "nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new-session -s";
      tl = "tmux list-sessions";
      tksv = "tmux kill-server";
      tks = "tmux kill-session -t";
      open = "xdg-open";
    };
    initContent = lib.mkOrder 1000 ''
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd ' ' edit-command-line
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "vincent.aceto@gmail.com";
        name = "vinnyA3";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.lazygit.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [ "~/.config/alacritty/themes/noctalia.toml" ];
        live_config_reload = true;
      };

      window = {
        opacity = 0.92;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 11.0;
        offset = {
          x = 0;
          y = 1;
        };

        glyph_offset = {
          x = 0;
          y = 1;
        };

        normal.family = "MonaspiceNe Nerd Font";
        normal.style = "Regular";
      };
    };
  };

  # programs.ghostty = {
  #   enable = false;
  #   systemd = {
  #     enable = false;
  #   };
  #   settings = {
  #     theme = "noctalia"; # theme is automatically provided by noctalia's theming templates
  #     font-size = 11;
  #     window-padding-x = 8;
  #     window-padding-y = 8;
  #     background-opacity = 0.94;
  #     # async-backend = "epoll"; # enable for hyprland
  #   };
  # };

  programs.tmux = {
    keyMode = "vi";
    enable = true;
    mouse = true;
    newSession = false;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-a";
    baseIndex = 1;
    plugins = with pkgs; [
      {
        plugin = pkgs.unstable.tmuxPlugins.dotbar;
        extraConfig = ''
          set -g @tmux-dotbar-position top
          set -g @tmux-dotbar-session-text "#H"
        '';
      }

      tmuxPlugins.pain-control
      tmuxPlugins.tmux-floax
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -sg escape-time 0
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"
    '';
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
  };

  programs.vesktop = {
    enable = true;
    vencord.useSystem = true;
  };

  programs.imv.enable = true;

  programs.yazi.enable = true;

  ## SSH config setup
  programs.ssh = {
    enable = true;
  };

  services.ssh-agent.enable = true;
}
