{
  config,
  pkgs,
  homeUser,
  ...
}:
let
  homeDir = "/home/${homeUser}";
in
{
  home = {
    # let home manager know what paths it should manage and for who
    username = homeUser;
    homeDirectory = homeDir;
    stateVersion = "25.11";
    shell = {
      enableZshIntegration = true;
    };
  };

  # force modern apps to broadcast 'prefer dark' scheme to Chromium
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # dots symlinks
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink homeDir + "/.dotfiles/config/hypr";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  # === COMMON ===
  # Common packages

  home.packages = with pkgs; [
    # === unstable pkgs
    unstable.cliamp
    unstable.niri
    # ===
    neovim
    qutebrowser
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
    cava
    (symlinkJoin {
      name = "vesktop-wrapped";
      paths = [ vesktop ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        # Remove the original shortcut to prevent any duplicates
        rm -f $out/share/applications/vesktop.desktop

        mkdir -p $out/share/applications
        cat > $out/share/applications/vesktop.desktop <<EOF
        [Desktop Entry]
        Name=Vesktop
        Exec=vesktop --disable-gpu-memory-buffer-video-frames --disable-features=UseOzonePlatform --ozone-platform=wayland %U
        Icon=vesktop
        Type=Application
        Categories=Network;InstantMessaging;
        Terminal=false
        MimeType=x-scheme-handler/discord;
        EOF
      '';
    })
    nwg-look
    pinta
  ];
}
