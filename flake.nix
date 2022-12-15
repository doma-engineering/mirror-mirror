# This is a nix flake, which installs gh and jq from nixpkgs.

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux; in {
      defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.gh;

      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = [ pkgs.gitAndTools.gh pkgs.jq ];
      };
    };
}