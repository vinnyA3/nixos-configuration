{ homeUser, pkgs, ... }:
let
  xdgDefaultImageViewer = [ "imv.desktop" ];
in
{
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    desktopEntries = {
      imv = {
        name = "imv";
        genericName = "lightweight image viewer";
        exec = "imv";
        type = "Application";
        terminal = false;
      };

      ytm = {
        name = "Youtube Music";
        genericName = "Youtube Music Web App";
        exec = "chromium --app=https://music.youtube.com/";
        icon = "/home/${homeUser}/Pictures/pfps/Reze.jpg";
        type = "Application";
        categories = [
          "WebBrowser"
          "Network"
        ];
      };

      chatgpt = {
        name = "ChatGPT";
        genericName = "ChatGPT Web App";
        exec = "chromium --app=https://chatgpt.com/";
        icon = "/home/${homeUser}/Pictures/pfps/Crack.jpg";
        type = "Application";
        categories = [
          "WebBrowser"
          "Network"
        ];
      };
    };

    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = builtins.listToAttrs (
        map
          (v: {
            name = v;
            value = xdgDefaultImageViewer;
          })
          [
            "image/png"
            "image/jpg"
            "image/jpeg"
            "image/gif"
          ]
      );
    };
  };
}
