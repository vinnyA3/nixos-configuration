{ pkgs }:

{
  allowUnfree = false;
  
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "main";
      paths = [
        docker
        git
      ];
    };
  };

  systemd.packages = [ pkgs.ssh-agent ];

  systemd.user.services = {
    docker = {
      enable = true;
      description = "Docker Daemon - enable on startup";  
    };
    
    ssh-agent = {
      enable = true;
      description = "Start SSH Agent";  
    };
  };

  programs.ssh = {
    enable = true;
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
}
