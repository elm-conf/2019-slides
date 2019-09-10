{ ... }:
let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  nixpkgs = import sources.nixpkgs { };
in with nixpkgs;
stdenv.mkDerivation {
  name = "slides";
  buildInputs = [ elmPackages.elm niv.niv ];
}
