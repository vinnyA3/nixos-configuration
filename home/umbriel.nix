{ lib, ... }:
{
  programs.umbriel = {
    enable = true;

    settings = {
      include = {
        files = [
          "~/.config/umbriel/noctalia.toml"
        ];
      };

      # Session
      general = {
        autostart = [ "noctalia" ];
        mod_key = "Super";
        xwayland = true;
        show_cheatsheet = false;
      };

      # Outputs
      output = lib.mkDefault {
        "eDP-1" = {
          scale = 1.75;
        };
      };

      # Input
      input = {
        keyboard = {
          layout = "us";
        };

        touchpad = {
          tap = true;
          natural_scroll = true;
        };

        cursor = {
          hide_timeout_ms = 10000;
        };
      };

      # Layout
      layout = {
        mode = "scrolling";
        gap = 16;

        # Niri's preset column widths.
        extent_presets = [
          0.33333
          0.5
          0.66667
        ];

        scrolling = {
          default_extent_fraction = 0.5;
          center_focused = "never";
          center_underfull_strip = false;
        };
      };

      # Appearance
      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        outer_border_width = 0;
        corner_radius = 4;

        shadow = {
          enabled = true;
          softness = 30;
          offset_x = 0;
          offset_y = 5;
        };

        blur = {
          enabled = true;
          optimized = true;
        };
      };

      # Window rules
      window_rule = [
        # Blur windows using the non-optimized path.
        {
          blur = true;
          blur_optimized = true;
        }

        # Noctalia settings window.
        {
          match.app_id = "^dev[.]noctalia[.]Noctalia$";
          default_floating = true;
          default_floating_size_px = {
            width = 1080;
            height = 920;
          };
        }

        # Firefox picture-in-picture.
        {
          match = {
            app_id = "firefox$";
            title = "^Picture-in-Picture$";
          };

          default_floating = true;
          default_maximize = false;
        }
      ];

      # Layer rules
      layer_rule = [
        {
          match.namespace =
            "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";

          blur = false;
          blur_optimized = false;
        }
      ];

      # Keybindings
      #
      # Umbriel replaces its built-in keybind set when this table is defined.
      # Keep every desired binding here.
      keybinds = {
        "Mod+Return" = {
          action = "spawn:foot";
          repeat = false;
        };

        "Mod+Space" = lib.mkDefault "spawn:noctalia msg panel-toggle launcher";

        "Super+Alt+L" = "spawn:noctalia msg session lock";

        "Mod+Escape" = "spawn:noctalia msg panel-toggle session";

        # Moved from Mod+Escape to avoid a binding conflict.
        "Mod+Shift+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };

        "Mod+Ctrl+Space" =
          "spawn:noctalia msg panel-toggle wallpaper";

        "Mod+Alt+Space" =
          "spawn:noctalia msg panel-toggle control-center";

        "Mod+Shift+Space" =
          "spawn:noctalia msg bar-toggle Primary";

        "Mod+Shift+Slash" = "cheatsheet-toggle";

        "Mod+O" = {
          action = "overview-toggle";
          repeat = false;
        };

        # Audio and media
        "XF86AudioRaiseVolume" =
          "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";

        "XF86AudioLowerVolume" =
          "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";

        "XF86AudioMute" =
          "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "XF86AudioMicMute" =
          "spawn:wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "XF86AudioPlay" = "spawn:playerctl play-pause";
        "XF86AudioStop" = "spawn:playerctl stop";
        "XF86AudioPrev" = "spawn:playerctl previous";
        "XF86AudioNext" = "spawn:playerctl next";

        # Brightness
        "XF86MonBrightnessUp" =
          "spawn:brightnessctl --class=backlight set +10%";

        "XF86MonBrightnessDown" =
          "spawn:brightnessctl --class=backlight set 10%-";

        # Window focus
        "Mod+Left" = "window-focus-left";
        "Mod+H" = "window-focus-left";

        "Mod+Right" = "window-focus-right";
        "Mod+L" = "window-focus-right";

        "Mod+Up" = "window-focus-up";
        "Mod+K" = "window-focus-up";

        "Mod+Down" = "window-focus-down";
        "Mod+J" = "window-focus-down";

        "Mod+Home" = "column-focus-first";
        "Mod+End" = "column-focus-last";

        # Move windows and columns
        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+H" = "column-move-left";

        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+Ctrl+L" = "column-move-right";

        "Mod+Ctrl+Up" = "window-move-up";
        "Mod+Ctrl+K" = "window-move-up";

        "Mod+Ctrl+Down" = "window-move-down";
        "Mod+Ctrl+J" = "window-move-down";

        "Mod+Ctrl+Home" = "column-move-to-first";
        "Mod+Ctrl+End" = "column-move-to-last";

        # Focus another output
        "Mod+Shift+Left" = "output-focus-left";
        "Mod+Shift+H" = "output-focus-left";

        "Mod+Shift+Right" = "output-focus-right";
        "Mod+Shift+L" = "output-focus-right";

        "Mod+Shift+Up" = "output-focus-up";
        "Mod+Shift+K" = "output-focus-up";

        "Mod+Shift+Down" = "output-focus-down";
        "Mod+Shift+J" = "output-focus-down";

        # Move a column to another output
        "Mod+Shift+Ctrl+Left" = "column-move-to-output-left";
        "Mod+Shift+Ctrl+H" = "column-move-to-output-left";

        "Mod+Shift+Ctrl+Right" = "column-move-to-output-right";
        "Mod+Shift+Ctrl+L" = "column-move-to-output-right";

        "Mod+Shift+Ctrl+Up" = "column-move-to-output-up";
        "Mod+Shift+Ctrl+K" = "column-move-to-output-up";

        "Mod+Shift+Ctrl+Down" = "column-move-to-output-down";
        "Mod+Shift+Ctrl+J" = "column-move-to-output-down";

        # Workspace navigation
        "Mod+Page_Down" = "workspace-next";
        "Mod+U" = "workspace-next";

        "Mod+Page_Up" = "workspace-previous";
        "Mod+I" = "workspace-previous";

        "Mod+Shift+Page_Down" = "workspace-move-down";
        "Mod+Shift+U" = "workspace-move-down";

        "Mod+Shift+Page_Up" = "workspace-move-up";
        "Mod+Shift+I" = "workspace-move-up";

        # Move the focused column between adjacent workspaces
        "Mod+Ctrl+Page_Down" = "column-move-to-workspace-next";
        "Mod+Ctrl+U" = "column-move-to-workspace-next";

        "Mod+Ctrl+Page_Up" = "column-move-to-workspace-previous";
        "Mod+Ctrl+I" = "column-move-to-workspace-previous";

        # Numbered workspaces
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";

        # Move the focused column to a numbered workspace
        "Mod+Ctrl+1" = "column-move-to-workspace:1";
        "Mod+Ctrl+2" = "column-move-to-workspace:2";
        "Mod+Ctrl+3" = "column-move-to-workspace:3";
        "Mod+Ctrl+4" = "column-move-to-workspace:4";
        "Mod+Ctrl+5" = "column-move-to-workspace:5";
        "Mod+Ctrl+6" = "column-move-to-workspace:6";
        "Mod+Ctrl+7" = "column-move-to-workspace:7";
        "Mod+Ctrl+8" = "column-move-to-workspace:8";
        "Mod+Ctrl+9" = "column-move-to-workspace:9";

        # Window grouping
        "Mod+BracketLeft" = "window-consume-or-expel-left";
        "Mod+BracketRight" = "window-consume-or-expel-right";

        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-right";

        "Mod+W" = {
          action = "column-toggle-tabbed";
          repeat = false;
        };

        # Width and height
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Shift+R" = "window-cycle-primary-extent-back";

        "Mod+Ctrl+Shift+R" = "window-cycle-secondary-extent";

        "Mod+Minus" = "window-modify-primary-extent:-0.1";
        "Mod+Equal" = "window-modify-primary-extent:0.1";

        "Mod+Shift+Minus" = "window-modify-secondary-extent:-0.1";
        "Mod+Shift+Equal" = "window-modify-secondary-extent:0.1";

        # Window state
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };

        "Mod+F" = {
          action = "window-toggle-maximize";
          repeat = false;
        };

        "Mod+Shift+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };

        "Mod+M" = {
          action = "window-toggle-maximize-to-edges";
          repeat = false;
        };

        "Mod+V" = {
          action = "window-toggle-floating";
          repeat = false;
        };

        "Mod+Shift+V" = {
          action = "window-focus-switch-floating";
          repeat = false;
        };

        "Mod+C" = "column-center";

        # Scroll between workspaces
        "Mod+WheelDown" = "workspace-next";
        "Mod+WheelUp" = "workspace-previous";

        "Mod+Ctrl+WheelDown" = "column-move-to-workspace-next";
        "Mod+Ctrl+WheelUp" = "column-move-to-workspace-previous";

        # Horizontal scrolling / column navigation
        "Mod+WheelRight" = "window-focus-right";
        "Mod+WheelLeft" = "window-focus-left";

        "Mod+Ctrl+WheelRight" = "column-move-right";
        "Mod+Ctrl+WheelLeft" = "column-move-left";

        "Mod+Shift+WheelDown" = "window-focus-right";
        "Mod+Shift+WheelUp" = "window-focus-left";

        "Mod+Ctrl+Shift+WheelDown" = "column-move-right";
        "Mod+Ctrl+Shift+WheelUp" = "column-move-left";

        # Session
        "Mod+Shift+E" = {
          action = "session-quit";
          repeat = false;
        };

        "Ctrl+Alt+Delete" = {
          action = "session-quit";
          repeat = false;
        };

        "Mod+Shift+P" = "dpms-off";
      };

      # Hot corners
      hot_corners = {
        top_left = {
          enabled = true;
          delay_ms = 450;
          action = "overview-open";
        };
      };
    };
  };
}
