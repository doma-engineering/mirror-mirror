# Mirrors

Readme for this script:

This script will clone all the repositories from a GitHub organization.
It uses gh, a GitHub CLI tool, and jq, a JSON parser.
You can install it with nix: nix shell nixpkgs#gitAndTools.gh nixpkgs#jq. Run `shell.sh` to do that.
But this script comes with flake.nix, so you can just run it with direnv with `direnv allow`.

An ad-hoc single-user install for modern `nix` which enables flakes and installs `home-manager`, along with `direnv`, can be found in a [cognivore's repo](https://github.com/cognivore/nix-home).

