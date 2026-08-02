{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    envExtra = ''
      export EDITOR=nvim
      export SUDO_EDITOR=nvim
      # ripgrep
      export RIPGREP_CONFIG_PATH=$HOME
      # colored, pretty man pages - requires bat (https://github.com/sharkdp/bat) binary
      export MANROFFOPT="-c"
      export MANPAGER="sh -c 'col -bx | bat -l man -p'"
      export PATH=$PATH:$HOME/.local/bin
    '';

    shellAliases = {
      ":q" = "exit";
      vim = "nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new-session -s";
      tl = "tmux list-sessions";
      tksv = "tmux kill-server";
      tks = "tmux kill-session -t";
      open = "xdg-open";
      c = "opencode";
      cat = "bat";
    };

    initContent = lib.mkOrder 1000 ''
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd ' ' edit-command-line
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
}
