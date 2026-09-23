{
  services.power-profiles-daemon.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };
}

