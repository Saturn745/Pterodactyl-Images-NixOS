[![status-badge](https://ci.kernel.templeos.win/api/badges/1/status.svg)](https://ci.kernel.templeos.win/repos/1)
# Pterodactyl-Images-NixOS

This repository contains OCI Images (Docker, Podman, etc), and [Pterodactyl Eggs](https://pterodactyl.io/community/config/eggs/creating_a_custom_egg.html) meant to be used with [Pterodactyl Panel](https://pterodactyl.io)

All images use [NixOS](https://nixos.org) as the base OS and provide only what is required to run most servers. Some of these images can be used with the [offical Pterodactyl Eggs](https://github.com/parkervcp/eggs) by just adding the image to the egg, however some may provide a custom egg if necessary.

# Current Images

### [Java](java/)
* [Java 17](java/17)
  * Image: `codeberg.org/saturn745/pterodactyl-nixos:java17`

### [Python](python/)
* [Python 3 (Poetry)](python/3-poetry)
  * Image: `codeberg.org/saturn745/pterodactyl-nixos:python3`
  * Details: Image with Python 3, [Poetry Dependency Manager](https://python-poetry.org/), and Git
  * Egg: [egg-python-generic-peotry.json](python/3-poetry/egg-python-generic-peotry.json)

# Image Updates

All images get automatically rebuilt based off of the offical [Nix OCI Image](https://hub.docker.com/r/nixos/nix) at 2:00 PM (UTC) and on every change to the images with the [CI](https://ci.kernel.templeos.win/repos/1)