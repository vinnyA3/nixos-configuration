{
  config,
  inputs,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  # Done and done ... we need to test the package updates now....
  home.username = "qwerty";
  home.homeDirectory = "/home/qwerty";

  home.stateVersion = "25.11";

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
