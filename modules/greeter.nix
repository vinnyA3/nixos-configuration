{ user }:
{ pkgs, config, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --background matrix --time --remember --cmd start-umbriel";
        user = user;
      };
    };
  };
}
