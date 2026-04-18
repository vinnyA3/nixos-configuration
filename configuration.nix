# System Config
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-beelink";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  hardware.bluetooth.enable = true;

  services.blueman.enable = true;

  services.printing.enable = true; # CUPS

  # Enable sound.
  # services.pulseaudio.enable = true; # boo..
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  services.getty.autologinUser = "qwerty";

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

  users.groups.nixconf = {
    members = [ "qwerty" ];
  };

  users.users.qwerty = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "sudo"
    ];

    shell = pkgs.zsh;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    clang-tools
    stdenv.cc.cc
  ];

  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
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

  # List services that you want to enable:
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd hyprland";
        user = "qwerty";
      };
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # custom trusted root ca certificates
  security.pki.certificateFiles = [
    ./ssl/certs/ca.pem
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
