<img
  src="./.github/miku.gif"
  alt="nixos logo"
  style="display: inline-block;"
  width="50"
  height="50">&nbsp;
NixOS Configuration
====

Here are my current [NixOS](https://nixos.org/) configuration files!

## Current Machines (hosts):
  - **nixos-beelink**: my beelink ser8 machine

## Setup

### New Machine
1. install git w/ `nix-env`
2. clone dotfiles repo into default nix directory
    - `cd /etc/nixos`
    - `git clone https://github.com/vinnyA3/nixos-configuration.git`
3. build: `sudo nixos-rebuild switch`
4. profit
