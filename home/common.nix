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

  # Dots symlinks - any dotfiles that I'd like to keep out of declarative nix config
  home.file.".config/qutebrowser/theming/__init__.py".source =
    config.lib.file.mkOutOfStoreSymlink homeDir
    + "/.dotfiles/nixos/config/qutebrowser/theming/__init__.py";

  home.file.".config/qutebrowser/theming/draw.py".source =
    config.lib.file.mkOutOfStoreSymlink homeDir
    + "/.dotfiles/nixos/config/qutebrowser/theming/draw.py";

  home.file.".config/qutebrowser/theming/noctalia-colors-template.json".source =
    config.lib.file.mkOutOfStoreSymlink homeDir
    + "/.dotfiles/nixos/config/qutebrowser/theming/noctalia-colors-template.json";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "mori-calliope-x";
      size = 24;
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
