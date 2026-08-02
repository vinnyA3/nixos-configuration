{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/New_York";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(meta, esc)";
            esc = "overload(esc, capslock)";
          };
        };
      };
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    clang-tools
    stdenv.cc.cc
  ];

  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  environment.variables.PATH = "${pkgs.clang-tools}/bin:$PATH";
  environment.variables.CPATH = "${pkgs.glibc.dev}/include";

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
}
