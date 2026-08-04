{ pkgs, ...}:
{
  home.packages = with pkgs; [
    unstable.cliamp
    manga-tui
    cava
    mpv
    nexusmods-app-unfree
    (symlinkJoin {
      name = "vesktop-wrapped";
      paths = [ vesktop ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        # Remove the original shortcut to prevent any duplicates
        rm -f $out/share/applications/vesktop.desktop

        mkdir -p $out/share/applications
        cat > $out/share/applications/vesktop.desktop <<EOF
        [Desktop Entry]
        Name=Vesktop
        Exec=vesktop --disable-gpu-memory-buffer-video-frames --disable-features=UseOzonePlatform --ozone-platform=wayland %U
        Icon=vesktop
        Type=Application
        Categories=Network;InstantMessaging;
        Terminal=false
        MimeType=x-scheme-handler/discord;
        EOF
      '';
    })
  ];
}
