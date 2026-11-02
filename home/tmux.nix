{ pkgs, ... }:
{
  programs.tmux = {
    keyMode = "vi";
    enable = true;
    mouse = true;
    newSession = false;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-a";
    baseIndex = 1;
    plugins = with pkgs; [
      {
        plugin = pkgs.unstable.tmuxPlugins.dotbar;
        extraConfig = ''
          set -g @tmux-dotbar-position top
          set -g @tmux-dotbar-fg-session @noctalia_on_surface_variant
          set -g @tmux-dotbar-session-text "[#S]"
        '';
      }

      tmuxPlugins.pain-control
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      source-file ~/.config/tmux/themes/noctalia.conf
      set -sg escape-time 0
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"
    '';
  };
}
