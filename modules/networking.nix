{
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 8081 ]; # localsend - 53317; 8081 react-native
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
