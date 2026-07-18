{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [ "~/.config/alacritty/themes/noctalia.toml" ];
        live_config_reload = true;
      };

      window = {
        opacity = 0.92;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 11.0;
        offset = {
          x = 0;
          y = 1;
        };

        glyph_offset = {
          x = 0;
          y = 1;
        };

        normal.family = "MonaspiceNe Nerd Font";
        normal.style = "Regular";
      };
    };
  };
}
