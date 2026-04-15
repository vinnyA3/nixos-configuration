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
in
{
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

  home.packages = with pkgs; [
    neovim
    qutebrowser # check
    bat
    ripgrep
    fzf
    brave
    mpv
    ffmpeg
    yt-dlp
    pass
    pinentry-curses
    btop
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
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

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
    };
    initContent = lib.mkOrder 1000 ''
      fh() {
        print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
      }

      zle -N fh
      bindkey '^R' fh

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
    };
  };

  programs.lazygit.enable = true;

  programs.ghostty = {
    enable = true;
    systemd = {
      enable = false;
    };
    settings = {
      theme = "noctalia"; # theme is automatically provided by noctalia's theming templates
      font-size = 11;
      window-padding-x = 8;
      window-padding-y = 8;
      background-opacity = 0.94;
      async-backend = "epoll";
    };
  };

  programs.tmux = {
    keyMode = "vi";
    enable = true;
    mouse = true;
    newSession = true;
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
    ];
    extraConfig = ''
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

  programs.fd.enable = true;

  programs.jq.enable = true;

  programs.cava = {
    enable = true;
    settings = {
      color = {
        # noctalia theme is automatically provided by noctalia's theming templates!
        theme = "noctalia";
      };
    };
  };

  ## SSH config setup
  programs.ssh = {
    enable = true;
  };

  services.ssh-agent.enable = true;
}
