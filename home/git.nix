{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "vincent.aceto@gmail.com";
        name = "vinnyA3";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.lazygit.enable = true;
}
