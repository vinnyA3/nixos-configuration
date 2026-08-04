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
    unstable.niri
    # ===
    pass
    xfce.thunar
  ];
}
