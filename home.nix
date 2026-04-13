{
  config,
  inputs,
  pkgs,
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
  };

  # dots symlinks
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink homeDir + "/.dotfiles/config/hypr";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh
    neovim
    qutebrowser
    ghostty
    git
    starship
    bat
    eza
    ripgrep
    fzf
    brave
    mpv
    ffmpeg
    yt-dlp
    pass
    pinentry-curses
    lazygit
    btop
    localsend
    cava
    python3
    libnotify
    zip
    unzip
    playerctl
    jq
    zathura
    xfce.thunar
    adw-gtk3
    wl-clipboard
    glib
    lxappearance
    fd
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  ## SSH config setup
  programs.ssh = {
    enable = true;
  };

  services.ssh-agent.enable = true;
}
