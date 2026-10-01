{
  services.upower.enable = true;
  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };
}

