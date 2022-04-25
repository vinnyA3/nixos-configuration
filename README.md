<img
  src="./.github/nixos.png"
  alt="nixos logo"
  style="display: inline-block;"
  width="50"
  height="50">&nbsp;
NixOS Configuration
====

Here are my [NixOS](https://nixos.org/) configuration files!

## Current Machines (hosts):
  - **nixvm**: homelab server
  - **zerodays**: home desktop (legacy)

## Getting Started

> :warning: if you're looking to test the configuration only, make sure to
> backup your current configuration before running the linking script!

To get started:
  * cd & clone repo to **/etc/nixos**:
  ```bash
  git clone https://github.com/vinnyA3/nixos-configuration.git \
  && cd nixos-configuration
  ```

  * run the linking / init script:```./ln-host <desired host config name in 'hosts'>```
    - example:
    ```bash
    ./ln-host 'nixvm'
    ```

  * *optional* - if you're setting up your NixOS env from scratch, you can
    generate your hardware config now:
    ```bash
    nixos-generate-config
    ```

  * finally, build the configuration:
    - for good measure, test the build: ```nixos-rebuild dry-build```
    - when ready, enable on boot & build: ```nixos-rebuild switch```

## User Nix Configs

Some hosts, in `./hosts`, have specific user configs.  There files are nix
configs that control the environment at the user-level.  Just copy these to
your user's `~/.nixpkgs` to spin up the env.
