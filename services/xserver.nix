{ pkgs, ... }:

{
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.autorun = true;
    services.xserver.layout = "us";

    # Enable xmonad and include extra packages
    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };

    # Use lightdm
    services.xserver.displayManager.lightdm = {
      enable = true;
      greeters.gtk.indicators = [ "~host" "~spacer" "~clock" "~spacer" "~a11y" "~session" "~power"];
    };

    services.redshift = {
      enable = true; 
      latitude = "40.579532";
      longitude = "-74.150201";
      temperature = {
        day = 6500;
        night = 3000;
      };
    };

    fonts = {
      enableFontDir = true; 
      fonts = with pkgs; [
        gohufont
        nerdfonts # find actual pkgs you use fonts from ...
        opensans-ttf
        siji
      ];
    };
}
