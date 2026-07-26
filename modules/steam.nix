{
  programs.steam = {
    enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # steam/proton needs this
  };
}
