{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "~/.config/foot/themes/noctalia";
        font = "MonaspiceNe Nerd Font:weight=Regular:size=11";
        pad = "10x10x10x10";
        line-height = 16;
      };

      colors-dark = {
        alpha = 0.90;
      };
    };
  };

  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       import = [ "~/.config/alacritty/themes/noctalia.toml" ];
  #       live_config_reload = true;
  #     };
  #
  #     window = {
  #       opacity = 0.92;
  #       padding = {
  #         x = 10;
  #         y = 10;
  #       };
  #     };
  #
  #     font = {
  #       size = 11.0;
  #       offset = {
  #         x = 0;
  #         y = 1;
  #       };
  #
  #       glyph_offset = {
  #         x = 0;
  #         y = 1;
  #       };
  #
  #       normal.family = "MonaspiceNe Nerd Font";
  #       normal.style = "Regular";
  #     };
  #   };
  # };
}
