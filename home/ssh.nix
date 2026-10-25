{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  services.ssh-agent.enable = true;
}
