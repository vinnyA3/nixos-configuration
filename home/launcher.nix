{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };

    settings = {
      theme = {
        dark = {
          name = "noctalia";
        };
      };
    };
  };
}
